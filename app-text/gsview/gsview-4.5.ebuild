# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gsview/gsview-4.5.ebuild,v 1.1 2003/12/09 20:54:33 lanius Exp $

DESCRIPTION="gsView PostScript and PDF viewer"
SRC_URI="ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/ghostgum/gsv45src.zip"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/gsview/"

SLOT="0"
LICENSE="Aladdin"
KEYWORDS="~x86"

RDEPEND=">=x11-libs/gtk+-1.2
	app-text/ghostscript-afpl"

src_compile() {
	## copy Unix makefile
	ln -s srcunx/unx.mak Makefile

	## run Makefile
	make || die "Error compiling files."
}

src_install() {
	dobin bin/gsview bin/esptool

	insinto /usr/share/applications
	newins srcunx/gvhelp.txt gview

	doman srcunx/gsview.1

	dodoc gsview.css cdorder.txt regorder.txt Readme.txt LICENCE
	dohtml *.htm bin/*.htm

	insinto /etc/gsview
	doins src/printer.ini
}
