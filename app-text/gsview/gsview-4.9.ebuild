# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gsview/gsview-4.9.ebuild,v 1.2 2010/10/03 12:46:18 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

MY_PV="${PV/.}"

DESCRIPTION="gsView PostScript and PDF viewer"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/gsview/"
SRC_URI="ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/ghostgum/gsv${MY_PV}src.zip"

IUSE="doc"
SLOT="0"
LICENSE="Aladdin"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~amd64-linux ~x86-linux"

RDEPEND="=x11-libs/gtk+-1.2*
	app-text/epstool
	app-text/pstotext
	app-text/ghostscript-gpl"
DEPEND="app-arch/unzip
	=x11-libs/gtk+-1.2*"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	tc-export CC
}

src_compile() {
	ln -sf srcunx/unx.mak Makefile

	## respect CFLAGS
	sed -i -e "s:^CFLAGS=-O :CFLAGS=${CFLAGS} :g" Makefile
	sed -i -e "s:GSVIEW_DOCPATH:\"${EPREFIX}/usr/share/doc/${PF}/html/\":" srcunx/gvx.c

	## run Makefile
	# bug #283165
	emake -j1 || die "Error compiling files."
}

src_install() {
	dobin bin/gsview

	doman srcunx/gsview.1

	dodoc gsview.css cdorder.txt regorder.txt

	if use doc
	then
		dobin "${FILESDIR}"/gsview-help
		dohtml *.htm bin/*.htm
	fi

	insinto /etc/gsview
	doins src/printer.ini

	make_desktop_entry gsview Gsview "" "Office" ||
		die "Couldn't make gsview desktop entry"
}
