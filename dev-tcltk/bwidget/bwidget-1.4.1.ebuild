# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/bwidget/bwidget-1.4.1.ebuild,v 1.1 2002/08/14 23:18:01 aliz Exp $

DESCRIPTION="The BWidget toolkit is a high-level widget set for Tcl/Tk. It contains widgets such as progress bars, 3D separators, various manager widgets for toplevels, frames, paned or scrolled windows, button boxes, notebooks or dialogs as well as composite widgets such as comboboxes, spin boxes and tree widgets. The BWidget toolkit is completely written in Tcl so no compiled extension library is required"

MY_PN=${PN/bw/BW}
MY_P=${MY_PN}-${PV}
HOMEPAGE="http://tcllib.sourceforge.net/"
SRC_URI="mirror://sourceforge/tcllib/${MY_P}.tar.gz"
LICENSE="LICENSE.txt"
SLOT="0"
KEYWORDS="x86"
DEPEND="dev-lang/tk 
	dev-lang/tcl"
S=${WORKDIR}/${MY_P}

src_install () {
	install -d ${D}/usr/lib/${P}
	install *.tcl ${D}/usr/lib/${P}
	cp -R images lang ${D}/usr/lib/${P}
	dodoc CHANGES.txt LICENSE.txt README.txt
	cp -R demo ${D}/usr/share/doc/${P}/
	dohtml BWman/*
}

