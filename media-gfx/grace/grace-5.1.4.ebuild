# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Grant Goodyear <g2boojum@hotmail.com>

S=${WORKDIR}/${P}
DESCRIPTION="Grace is a WYSIWYG 2D plotting tool for the X Window System"
SRC_URI="ftp://plasma-gate.weizmann.ac.il/pub/grace/src/${P}.tar.gz"
HOMEPAGE="http://plasma-gate.weizmann.ac.il/Grace/"

DEPEND="virtual/glibc virtual/x11
	>=x11-libs/openmotif-2.1
	>=media-libs/libpng-0.96
	>=media-libs/tiff-3.5
	pdflib? ( >=media-libs/pdflib-3.0.2 )"
	
RDEPEND="virtual/glibc virtual/x11
	>=x11-libs/openmotif-2.1
	>=media-libs/libpng-0.96
	>=media-libs/jpeg-6
	pdflib? ( >=media-libs/pdflib-3.0.2 )"

	
src_compile() {

	local myconf
	if [ -z "`use pdflib`" ] ; then
		myconf="--disable-pdfdrv"
	fi
	
	./configure --with-grace-home=/usr/share/grace			\
		--prefix=/usr						\
		--host=${CHOST}						\
		${myconf} || die
	
	cp doc/Makefile doc/Makefile.orig
	sed -e 's:$(GRACE_HOME)/doc:$(PREFIX)/share/doc/$(PF)/html:g'	\
		doc/Makefile.orig >doc/Makefile

	cp auxiliary/Makefile auxiliary/Makefile.orig
	sed -e 's:$(GRACE_HOME)/bin:$(PREFIX)/bin:g'			\
		auxiliary/Makefile.orig >auxiliary/Makefile

	cp grconvert/Makefile grconvert/Makefile.orig
	sed -e 's:$(GRACE_HOME)/bin:$(PREFIX)/bin:g'			\
		grconvert/Makefile.orig >grconvert/Makefile

	cp src/Makefile src/Makefile.orig
	sed -e 's:$(GRACE_HOME)/bin:$(PREFIX)/bin:g'			\
		src/Makefile.orig >src/Makefile

	cp grace_np/Makefile grace_np/Makefile.orig
	sed -e 's:$(GRACE_HOME)/lib:$(PREFIX)/lib:g'			\
		-e 's:$(GRACE_HOME)/include:$(PREFIX)/include:g'	\
		grace_np/Makefile.orig >grace_np/Makefile

	cp examples/Makefile examples/Makefile.orig
	sed -e 's:/examples:/share/doc/$(PF)/examples:g'		\
		-e 's:$(GRACE_HOME):$(PREFIX):g'			\
		examples/Makefile.orig >examples/Makefile

	emake || die
}

src_install() {

	make GRACE_HOME=${D}/usr/share/grace				\
		PREFIX=${D}/usr						\
    		install || die

	dodoc CHANGES COPYRIGHT ChangeLog DEVELOPERS LICENSE README

	dodir /usr/share/man/man1
	mv ${D}/usr/share/doc/${PF}/html/*.1 ${D}/usr/share/man/man1
    
	insinto /etc/env.d
	newins ${FILESDIR}/10grace-5.1.4 10grace
}

