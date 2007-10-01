# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/uclibc++/uclibc++-0.2.2-r1.ebuild,v 1.1 2007/10/01 22:47:12 solar Exp $

inherit eutils toolchain-funcs

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

DESCRIPTION="embedded C++ library"
HOMEPAGE="http://cxx.uclibc.org/"
SRC_URI="http://cxx.uclibc.org/src/uClibc++-${PV}.tar.bz2"

LICENSE="GPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~x86"
IUSE="debug static"

DEPEND=""

S=${WORKDIR}/uClibc++-${PV}

set_config() {
	local val
	sed -i -e "/$1/d" .config
	if [[ -n $2 && $2 != "n" ]]; then
		val="$1=${2:-y}"
		einfo "Enabling $1"
	else
		val="# $1 is not set"
		einfo "Disabling $1"
	fi
	echo "$val" >> .config
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s: -Wl,-s$: ${LDFLAGS}:" src/Makefile
	emake -j1 -s defconfig > /dev/null || die "defconfig failed"
	set_config UCLIBCXX_RUNTIME_PREFIX "\"/usr/${CTARGET}\""
	set_config BUILD_STATIC_LIB y
	if use static; then
		set_config BUILD_ONLY_STATIC_LIB y
	fi
	if use elibc_uclibc; then
		set_config UCLIBCXX_HAS_TLS n
	fi
	emake oldconfig
}

src_compile() {
	emake \
		STRIPTOOL="true" \
		OPTIMIZATION="${CXXFLAGS}" \
		CROSS=${CTARGET}- \
		|| die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodir /usr/bin
	dosym /usr/${CTARGET}/bin/g++-uc /usr/bin/g++-uc
	dodoc ChangeLog README TODO
}
