# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/uclibc++/uclibc++-0.2.1.ebuild,v 1.1 2006/09/09 22:29:15 vapier Exp $

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	make -s defconfig || die "defconfig failed"

	sed -i \
		-e "/^UCLIBCXX_RUNTIME_PREFIX=/s:=.*:\"/usr/${CTARGET}\"" \
		.config
	use debug && echo "CONFIG_DODEBUG=y" >> .config

	yes "" | make -s oldconfig || die "oldconfig failed"

	# has to come after make oldconfig, else it will be disabled
	echo "BUILD_STATIC_LIB=y" >> .config
	if use static ; then
		echo "BUILD_ONLY_STATIC_LIB=y" >> .config
	fi
}

src_compile() {
	emake ARCH_CFLAGS="${CFLAGS}" CROSS=${CTARGET}- || die "make failed"
}

src_test() {
	make test || die "test failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodir /usr/bin
	dosym /usr/${CTARGET}/bin/g++-uc /usr/bin/g++-uc
	dodoc ChangeLog README TODO
}
