# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gocr/gocr-0.3.6-r2.ebuild,v 1.15 2004/02/10 14:32:14 obz Exp $

DESCRIPTION="Converts PNM to ASCII"
SRC_URI="mirror://sourceforge/jocr/${P}.tar.gz"
HOMEPAGE="http://jocr.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE="tetex"

RDEPEND="=media-libs/netpbm-9.12*"
DEPEND="${RDEPEND}
	app-text/tetex
	virtual/ghostscript
	tetex? ( >=media-gfx/transfig-3.2.3d-r1 )"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
	cd ${S}
	autoconf
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
	econf
	make || die
	make src frontend database || die
	if [ `use tetex` ] ; then
		make examples || die
	fi
}

src_install() {
	addwrite "/usr/share/texmf"
	make install DESTDIR=${D}/usr || die
}
