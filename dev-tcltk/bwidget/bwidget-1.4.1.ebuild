# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/bwidget/bwidget-1.4.1.ebuild,v 1.8 2004/01/15 04:24:27 agriffis Exp $

DESCRIPTION="high-level widget set for Tcl/Tk completely written in Tcl"

MY_PN=${PN/bw/BW}
MY_P=${MY_PN}-${PV}
HOMEPAGE="http://tcllib.sourceforge.net/"
SRC_URI="mirror://sourceforge/tcllib/${MY_P}.tar.gz"

LICENSE="BWidget"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha"

DEPEND="dev-lang/tk
	dev-lang/tcl"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /usr/lib/${P}
	doins *.tcl
	cp -R images lang ${D}/usr/lib/${P}
	dodoc CHANGES.txt LICENSE.txt README.txt
	cp -R demo ${D}/usr/share/doc/${PF}/
	dohtml BWman/*
}
