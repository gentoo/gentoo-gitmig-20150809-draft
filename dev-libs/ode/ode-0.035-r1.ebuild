# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ode/ode-0.035-r1.ebuild,v 1.1 2003/06/24 05:02:36 george Exp $

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
append-flags -c

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
	eifno "Please note:"
	einfo "The package Makfile has been modified to honor user-set CFLAGS"
	einfo "- they were ignored previously"
	einfo "the package defined FLAGS were: "
	einfo "-c -Wall -fno-rtti -fno-exceptions -fomit-frame-pointer -ffast-math"
	einfo "(the -c is essential because of the way Makefile is constructed)"
}
