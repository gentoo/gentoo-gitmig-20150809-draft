# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/uclibc++/uclibc++-0.1.9.ebuild,v 1.1 2005/01/22 05:21:29 vapier Exp $

inherit eutils toolchain-funcs

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

DESCRIPTION="embedded C++ library"
HOMEPAGE="http://cxx.uclibc.org/"
SRC_URI="http://cxx.uclibc.org/src/uClibc++-${PV}.tbz2"

LICENSE="GPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="~arm ~ppc ~x86"
IUSE="debug static"

DEPEND=""

S=${WORKDIR}/uClibc++

src_unpack() {
	unpack ${A}
	cd ${S}
	make defconfig || die "defconfig failed"

	local target
	case $(tc-arch ${CTARGET}) in
		arm)	target="arm";;
		mips)	target="mips";;
		ppc)	target="powerpc";;
		x86)	target="i386";;
		*)		die "$(tc-arch ${CTARGET}) lists no defaults :/";;
	esac

	sed -i \
		-e '/^UCLIBCXX_RUNTIME_PREFIX=/d' \
		-e '/^TARGET_'${target}'/d' \
		.config

	echo "UCLIBCXX_RUNTIME_PREFIX=\"/usr/${CTARGET}\"" >> .config
	echo "TARGET_${target}=y" >> .config
	use debug && echo "CONFIG_DODEBUG=y" >> .config

	yes "" | make oldconfig || die "oldconfig failed"

	# has to come after make oldconfig, else it will be disabled
	echo "BUILD_STATIC_LIB=y" >> .config
	if use static ; then
		echo "BUILD_ONLY_STATIC_LIB=y" >> .config
	fi
}

src_compile() {
	emake -j1 ARCH_CFLAGS="${CFLAGS}" CROSS=${CTARGET}- || die "make failed"
}

src_test() {
	make test || die "test failed"
}

src_install() {
	make install PREFIX="${D}" || die
	dodir /usr/bin
	dosym /usr/${CTARGET}/bin/g++-uc /usr/bin/g++-uc
	dodoc ChangeLog README TODO
}
