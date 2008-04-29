# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/hardened-gcc/hardened-gcc-4.2.3.ebuild,v 1.1 2008/04/29 00:42:14 pappy Exp $

DESCRIPTION="The GNU C Compiler Suite with hardening"
HOMEPAGE="http://www.gentoo.org/proj/en/extreme-security"

GCCVER="4.2.3"
GCCPATH="pub/gcc/releases/gcc-${GCCVER}"
GCCFILE="gcc-${GCCVER}.tar.bz2"
GCC_MIR="ftp://gcc.gnu.org"

# the basic gcc source
SRC_URI="${SRC_URI} \
	${GCC_MIR}/${GCCPATH}/${GCCFILE}"

LICENSE="LGPL-2"
SLOT="1"

KEYWORDS="-x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	# hardcoding the CHOST in this ebuild (for x86 stages)
	# this breaks crosscompiling and multiple arch support
	# but it is a good first step to get the ebuild going.
	export CHOST="i486-pc-linux-gnu"

	export CFLAGS="-O2 -pipe -march=i486 -mtune=i686 -fforce-addr"
	export CXXFLAGS="${CFLAGS}"

	export CPPFLAGS=""
	export ASFLAGS=""
	export LDFLAGS=""

	if [[ "x${MAKEOPTS}y" == "xy" ]]
	then
		export MAKEOPTS="-j4"
	fi

	einfo "using CHOST:${CHOST}"
	einfo "using C(XX)FLAGS:${CFLAGS}:${CXXFLAGS}"
	einfo "using MAKEOPTS:${MAKEOPTS}"
}

src_unpack() {
	einfo "unpacking"
}

src_compile() {
	einfo "compiling"
}

src_install() {
	einfo "installing"
}

pkg_postinst() {
	einfo "doing postinstallation tasks"
}


