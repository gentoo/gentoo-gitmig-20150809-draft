# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/grace/grace-5.1.12.ebuild,v 1.1 2003/08/18 13:16:06 usata Exp $

inherit eutils

DESCRIPTION="WYSIWYG 2D plotting tool for the X Window System"
HOMEPAGE="http://plasma-gate.weizmann.ac.il/Grace/"
SRC_URI="ftp://plasma-gate.weizmann.ac.il/pub/grace/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="debug png jpeg pdflib"

DEPEND="virtual/x11
	virtual/motif
	>=sys-libs/zlib-1.0.3
	>=dev-libs/fftw-2.1.3
	>=app-sci/netcdf-3.0
	>=media-libs/t1lib-1.3.1
	>=media-libs/tiff-3.5
	png? ( >=media-libs/libpng-0.9.6 )
	jpeg? ( media-libs/jpeg )
	pdflib? ( >=media-libs/pdflib-4.0.3 )"
#	x11-libs/xmhtml

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}

	if has_version '>=media-libs/t1lib-5.0.0' ; then
		epatch ${FILESDIR}/${P}-t1lib-fix-gentoo.patch
	fi
}

src_compile() {
	econf \
		--with-grace-home=/usr/share/grace \
		--with-fftw \
		--enable-netcdf \
		`use_enable debug` \
		`use_enable jpeg jpegdrv` \
		`use_enable png pngdrv` \
		`use_enable pdflib pdfdrv` || die
		# --enable-xmhtml

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
	make \
		GRACE_HOME=${D}/usr/share/grace \
		PREFIX=${D}/usr \
		install || die

	dodoc CHANGES COPYRIGHT ChangeLog DEVELOPERS LICENSE README

	#dodir /usr/share/man/man1
	#mv ${D}/usr/share/doc/${PF}/html/*.1 ${D}/usr/share/man/man1
	doman ${D}/usr/share/doc/${PF}/html/*.1
	rm -f ${D}/usr/share/doc/${PF}/html/*.1

	dosym /usr/share/doc/${PF}/examples /usr/share/grace/examples

	insinto /etc/env.d
	doins ${FILESDIR}/10grace || die
}
