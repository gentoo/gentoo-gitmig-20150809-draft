# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gocr/gocr-0.3.6-r3.ebuild,v 1.2 2004/03/21 19:16:43 usata Exp $

DESCRIPTION="Converts PNM to ASCII"
SRC_URI="mirror://sourceforge/jocr/${P}.tar.gz"
HOMEPAGE="http://jocr.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
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
	cd ${S}/doc
	cp Makefile.in Makefile.orig
	sed -e "s:\$(DVIPS) \$?:\$(DVIPS) -o \$(OCRDOC).ps \$?:" \
		Makefile.orig > Makefile.in
	cd ../bin
	mv gocr.tcl gocr.orig
	sed -e "s:\.\./examples:/usr/share/gocr/fonts:" \
		gocr.orig > gocr.tcl
	cd ../src
	cp database.c database.orig
	sed -e "s:\./db/:${D}/usr/share/gocr/db/:" database.orig > database.c
	cd ../examples
	cp Makefile Makefile.orig
	sed -e "s:polish.pbm man.pbm:polish.pbm:" Makefile.orig > Makefile
}

src_compile() {
	addwrite "/usr/share/texmf/fonts/pk"
	addwrite "/usr/share/texmf/ls-R"
	econf || die
	emake -j1 || die
	emake -j1 src frontend database || die
	if [ "`use doc`" ] ; then
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
