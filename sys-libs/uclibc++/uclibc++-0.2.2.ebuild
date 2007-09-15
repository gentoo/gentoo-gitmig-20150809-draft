# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/uclibc++/uclibc++-0.2.2.ebuild,v 1.1 2007/09/15 02:57:12 vapier Exp $

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
	sed -i \
		-e "s:^# $2 is not set$:GO_HERE:" \
		-e "s:^$2=.*$:GO_HERE:" \
		.config
	local val
	if [[ -z $1 ]] || use $1 ; then
		val="$2=${3:-y}"
	else
		val="# $2 is not set"
	fi
	sed -i -e "s:^GO_HERE$:${val}:" .config
}
src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s: -Wl,-s$: ${LDFLAGS}:" src/Makefile
	emake -j1 -s defconfig > /dev/null || die "defconfig failed"
	set_config "" UCLIBCXX_RUNTIME_PREFIX "\"/usr/${CTARGET}\""
	set_config "" BUILD_STATIC_LIB
	set_config static BUILD_ONLY_STATIC_LIB
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
