# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gsview/gsview-4.8.ebuild,v 1.3 2006/04/21 17:08:17 vanquirius Exp $

inherit eutils

MY_PV="${PV/.}"
DESCRIPTION="gsView PostScript and PDF viewer"
SRC_URI="ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/ghostgum/gsv${MY_PV}src.zip"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/gsview/"

IUSE="doc"
SLOT="0"
LICENSE="Aladdin"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND="=x11-libs/gtk+-1.2*
	app-text/epstool
	virtual/ghostscript"
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gsesp.patch
}

src_compile() {
	## copy Unix makefile
	ln -s srcunx/unx.mak Makefile

	## respect CFLAGS
	sed -i -e "s:^CFLAGS=-O :CFLAGS=${CFLAGS} :g" Makefile
	sed -i -e "s:GSVIEW_DOCPATH:\"/usr/share/doc/${PF}/html/\":" srcunx/gvx.c

	## run Makefile
	make || die "Error compiling files."
}

src_install() {
	dobin bin/gsview

	doman srcunx/gsview.1

	dodoc gsview.css cdorder.txt regorder.txt

	if use doc
	then
		dobin ${FILESDIR}/gsview-help
		dohtml *.htm bin/*.htm
	fi

	insinto /etc/gsview
	doins src/printer.ini
}
