# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gocr/gocr-0.3.6-r2.ebuild,v 1.4 2002/10/04 05:05:30 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Converts PNM to ASCII"
SRC_URI="mirror://sourceforge/jocr/${P}.tar.gz"
HOMEPAGE="http://altmark.nat.uni-magdeburg.de/~jschulen/ocr/"

RDEPEND=">=media-libs/netpbm-9.12-r1"

DEPEND="${RDEPEND}
	app-text/tetex
	app-text/ghostscript"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

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

	econf || die
	make
	make src frontend database
	use tetex && ( \
		make examples || die
	)
}

src_install () {

	addwrite "/usr/share/texmf"

	make DESTDIR=${D} \
		install || die
#	dobin bin/gocr
#	exeinto /usr/bin
#	doexe bin/gocr.tcl
#	dolib.a src/libPgm2asc.a
#	insinto /usr/include
#	doins src/gocr.h
#	insinto /usr/share/gocr/db
#	doins db/*
#	doman man/man1/gocr.1
#	dodoc AUTHORS BUGS CREDITS HISTORY README* REMARK.txt REVIEW TODO gpl.html
#	docinto txt
#	dodoc doc/*.txt

#	use tetex && ( \
#		insinto /usr/share/gocr/db
#		docinto ps
#		dodoc doc/ocr.ps
#	)

}

