# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gsview/gsview-4.6.ebuild,v 1.11 2006/04/21 17:08:17 vanquirius Exp $

MY_PV="${PV/.}"
DESCRIPTION="gsView PostScript and PDF viewer"
SRC_URI="ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/ghostgum/gsv${MY_PV}src.zip"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/gsview/"

IUSE="doc"
SLOT="0"
LICENSE="Aladdin"
KEYWORDS="amd64 ppc x86"

RDEPEND="=x11-libs/gtk+-1.2*
	virtual/ghostscript"
DEPEND="app-arch/unzip
	!app-text/epstool"

src_compile() {
	## copy Unix makefile
	ln -s srcunx/unx.mak Makefile

	## respect CFLAGS
	sed -i -e "s:^CFLAGS=-O :CFLAGS=${CFLAGS} :g" Makefile

	## run Makefile
	make || die "Error compiling files."
}

src_install() {
	dobin bin/gsview bin/epstool

	insinto /usr/share/applications
	newins srcunx/gvxhelp.txt gview

	doman srcunx/gsview.1

	dodoc gsview.css cdorder.txt regorder.txt LICENCE

	if use doc
	then
		dohtml *.htm bin/*.htm
	fi

	insinto /etc/gsview
	doins src/printer.ini
}
