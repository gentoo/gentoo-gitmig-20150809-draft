# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/grace/grace-5.1.7-r2.ebuild,v 1.9 2003/04/24 11:26:56 vapier Exp $

DESCRIPTION="WYSIWYG 2D plotting tool for the X Window System"
SRC_URI="ftp://plasma-gate.weizmann.ac.il/pub/grace/src/${P}.tar.gz"
HOMEPAGE="http://plasma-gate.weizmann.ac.il/Grace/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="pdflib"

DEPEND="virtual/x11
	virtual/motif
	media-libs/libpng
	>=media-libs/tiff-3.5
	pdflib? ( >=media-libs/pdflib-3.0.2 )"

src_compile() {
	econf \
		--with-grace-home=/usr/share/grace \
		`use_enable pdflib pdfdrv` \
		|| die
	
	cp doc/Makefile doc/Makefile.orig
	sed -e 's:$(GRACE_HOME)/doc:$(PREFIX)/share/doc/$(PF)/html:g' \
		doc/Makefile.orig >doc/Makefile || die

	cp auxiliary/Makefile auxiliary/Makefile.orig
	sed -e 's:$(GRACE_HOME)/bin:$(PREFIX)/bin:g' \
		auxiliary/Makefile.orig >auxiliary/Makefile || die

	cp grconvert/Makefile grconvert/Makefile.orig
	sed -e 's:$(GRACE_HOME)/bin:$(PREFIX)/bin:g' \
		grconvert/Makefile.orig >grconvert/Makefile || die

	cp src/Makefile src/Makefile.orig
	sed -e 's:$(GRACE_HOME)/bin:$(PREFIX)/bin:g' \
		src/Makefile.orig >src/Makefile || die

	cp grace_np/Makefile grace_np/Makefile.orig
	sed -e 's:$(GRACE_HOME)/lib:$(PREFIX)/lib:g' \
		-e 's:$(GRACE_HOME)/include:$(PREFIX)/include:g' \
		grace_np/Makefile.orig >grace_np/Makefile || die

	cp examples/Makefile examples/Makefile.orig
	sed -e 's:/examples:/share/doc/$(PF)/examples:g' \
		-e 's:$(GRACE_HOME):$(PREFIX):g' \
		examples/Makefile.orig >examples/Makefile || die

	make || die
}

src_install() {
	make GRACE_HOME=${D}/usr/share/grace \
		PREFIX=${D}/usr \
    		install || die

	dodoc CHANGES COPYRIGHT ChangeLog DEVELOPERS LICENSE README

	#dodir /usr/share/man/man1
	#mv ${D}/usr/share/doc/${PF}/html/*.1 ${D}/usr/share/man/man1
	doman ${D}/usr/share/doc/${PF}/html/*.1
	rm -f ${D}/usr/share/doc/${PF}/html/*.1
    
	insinto /etc/env.d
	doins ${FILESDIR}/10grace
}
