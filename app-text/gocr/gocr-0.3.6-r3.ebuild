# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gocr/gocr-0.3.6-r3.ebuild,v 1.3 2004/04/08 17:27:02 vapier Exp $

inherit eutils

DESCRIPTION="Converts PNM to ASCII"
HOMEPAGE="http://jocr.sourceforge.net/"
SRC_URI="mirror://sourceforge/jocr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="doc"

RDEPEND=">=media-libs/netpbm-9.12"
DEPEND="${RDEPEND}
	virtual/ghostscript
	virtual/tetex
	doc? ( >=media-gfx/transfig-3.2.3d-r1 )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	cd ${S}
	autoconf || die
	sed -i -e "s:\$(DVIPS) \$?:\$(DVIPS) -o \$(OCRDOC).ps \$?:" doc/Makefile.in
	sed -i -e "s:\.\./examples:/usr/share/gocr/fonts:" bin/gocr.tcl
	sed -i -e "s:\./db/:${D}/usr/share/gocr/db/:" src/database.c
	sed -i -e "s:polish.pbm man.pbm:polish.pbm:" examples/Makefile
}

src_compile() {
	addwrite "/usr/share/texmf/fonts/pk"
	addwrite "/usr/share/texmf/ls-R"
	econf || die
	emake -j1 || die
	emake -j1 src frontend database || die
	if use doc ; then
		emake -j1 examples || die
	fi
}

src_install() {
	addwrite "/usr/share/texmf"
	make DESTDIR=${D} \
		prefix=/usr \
		exec_prefix=/usr \
		mandir=/usr/share/man \
		install || die
}
