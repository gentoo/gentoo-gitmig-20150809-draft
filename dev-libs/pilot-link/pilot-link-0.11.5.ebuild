# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pilot-link/pilot-link-0.11.5.ebuild,v 1.4 2003/02/28 16:54:59 liquidx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="suite of tools for moving data between a Palm device and a desktop"

SRC_URI="http://pilot-link.org/source/${P}.tar.bz2"
HOMEPAGE="http://www.pilot-link.org/"

SLOT="0"
LICENSE="GPL-2 | LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc "
IUSE="perl java tcltk python pic png readline"

DEPEND="virtual/glibc
	sys-libs/ncurses
	perl? ( sys-devel/perl )
	java? ( virtual/jre )
	tcltk? ( dev-lang/tcl dev-tcltk/itcl dev-lang/tk )
	python? ( dev-lang/python )
	png? ( media-libs/libpng )
	readline? ( sys-libs/readline )"

src_compile() {
	local myconf="--with-gnu-ld --includedir=/usr/include/libpisock"

	use pic && myconf="${myconf} --with-pic"

#	couldnt get this to work
#	use java \
#		&& myconf="${myconf} --with-java=yes" \
#		|| myconf="${myconf} --with-java=no"
	myconf="${myconf} --with-java=no"

#	http://gnu-designs.com/bugs/view_bug_page.php?f_id=259
#	use perl \
#		&& myconf="${myconf} --with-perl=yes" \
#		|| myconf="${myconf} --with-perl=no"
	myconf="${myconf} --with-perl=no"

	use python \
		&& myconf="${myconf} --with-python=yes" \
		|| myconf="${myconf} --with-python=no"

	use tcltk \
		&& myconf="${myconf} --with-tcl=yes --with-itcl=yes --with-tk=yes" \
		|| myconf="${myconf} --with-tcl=no --with-itcl=no --with-tk=no"

	use png && myconf="${myconf} --with-libpng=/usr"

	use readline \
		&& myconf="${myconf} --with-readline=yes" \
		|| myconf="${myconf} --with-readline=no"

#	make configure script:
#	  - look for ncurses rather than termcap
#	    http://gnu-designs.com/bugs/view_bug_page.php?f_id=381
#	  - link png check with more libraries
#	    http://gnu-designs.com/bugs/view_bug_page.php?f_id=380
	cp configure configure.old
	sed -e 's:-ltermcap:-lncurses:' \
	 -e 's:-lpng:-lpng -lz -lstdc++:' \
		configure.old > configure

#	fix pilot-debug.c
#	 http://gnu-designs.com/bugs/view_bug_page.php?f_id=129
	cp src/pilot-debug.c src/pilot-debug.c.old
	sed -e 's:TCL_MINOR_VERSION <4:TCL_MINOR_VERSION <3:' \
		src/pilot-debug.c.old > src/pilot-debug.c

	econf ${myconf} || die

#	so python doesnt violate sandbox
#	http://gnu-designs.com/bugs/view_bug_page.php?f_id=382
	cp bindings/Makefile bindings/Makefile.old
	sed -e 's:--prefix=$(prefix):--prefix=$(prefix) --root=$(DESTDIR):' \
		bindings/Makefile.old > bindings/Makefile
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	mv ${D}/*.hxx ${D}/usr/include/libpisock/

	dodoc ChangeLog README doc/README* doc/TODO NEWS AUTHORS
}
