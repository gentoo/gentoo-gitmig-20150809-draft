# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ode/ode-0.035-r1.ebuild,v 1.4 2003/07/02 07:27:52 george Exp $

inherit flag-o-matic

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Open Dynamics Engine SDK"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/opende/${P}.tgz"
HOMEPAGE="http://opende.sourceforge.net"

LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND="virtual/opengl"

#this package has to be compiled strictly with -O1
replace-flags -O? -O
#this is necessary here because of the way Makefile is composed
append-flags -c

pkg_setup() {
	#this (version of) package fails when built with gcc-3.3*
	GCC_VER=`gcc -dumpversion |cut -d. -f1,2`
	if [ $GCC_VER == "3.3" ]; then
		ewarn "Unfortunately this version of the package cannot (yet) be built with >=gcc-3.3"
		ewarn "You can install an older version of gcc and then use gcc-config to switch"
		ewarn "compiler version for the duration of the build."
		ewarn "Alternatively please see #22071 for more options."
		ewarn "We apologise for the inconvinience."
		die
	fi
}

src_unpack() {
	unpack ${A}

	#fix Makefile to honor user-defined CFLAGS instead of hardwired ones
	cd ${S}
	sed -i -e "s:C_FLAGS:CFLAGS:" Makefile

	#select appropriate platform
	cd ${S}/config
	sed -i -e "s,'PLATFORM=msvc','PLATFORM=unix-gcc'," user-settings || die
}

src_compile() {
	make || die
}

src_install() {
	dodir /usr/include/ode
	insinto /usr/include/ode
	doins include/ode/*.h

	dolib lib/libode.a
	dolib lib/libdrawstuff.a

	dodoc README CHANGELOG LICENSE.TXT
}

pkg_postinst() {
	einfo "Please note:"
	einfo "The package Makfile has been modified to honor user-set CFLAGS"
	einfo "- they were ignored previously"
	einfo "the package defined FLAGS were: "
	einfo "-Wall -fno-rtti -fno-exceptions -fomit-frame-pointer -ffast-math"
}
