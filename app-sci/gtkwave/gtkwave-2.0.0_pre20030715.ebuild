# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gtkwave/gtkwave-2.0.0_pre20030715.ebuild,v 1.2 2003/12/16 13:00:06 weeve Exp $

MY_P=${PN}-${PV/_pre20030715/pre4}
DESCRIPTION="A wave viewer for LXT and Verilog VCD/EVCD files"
HOMEPAGE="http://www.cs.man.ac.uk/apt/tools/gtkwave/index.html"
SRC_URI="ftp://ftp.cs.man.ac.uk/pub/amulet/gtkwave/2.0/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/x11
	>=x11-libs/gtk+-1.2*
	>=dev-libs/glib-1.2*
	dev-libs/libxml
	app-arch/bzip2"

S=${WORKDIR}/${MY_P}

src_compile() {

	econf || die
	emake || die

}

src_install() {

	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README
	dohtml -r doc/*

}
