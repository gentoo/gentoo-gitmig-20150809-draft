# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/grace/grace-5.1.12-r1.ebuild,v 1.7 2004/03/18 16:37:46 spyderous Exp $

inherit eutils

DESCRIPTION="WYSIWYG 2D plotting tool for the X Window System"
HOMEPAGE="http://plasma-gate.weizmann.ac.il/Grace/"
SRC_URI="ftp://plasma-gate.weizmann.ac.il/pub/grace/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
IUSE="debug png jpeg pdflib fftw netcdf"

DEPEND="virtual/x11
	x11-libs/openmotif
	>=sys-libs/zlib-1.0.3
	>=media-libs/t1lib-1.3.1
	>=media-libs/tiff-3.5
	fftw? ( =dev-libs/fftw-2* )
	netcdf? ( >=app-sci/netcdf-3.0 )
	png? ( >=media-libs/libpng-0.9.6 )
	jpeg? ( media-libs/jpeg )
	pdflib? ( >=media-libs/pdflib-4.0.3 )
	>=sys-apps/sed-4"
#	x11-libs/xmhtml

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}

	if has_version '>=media-libs/t1lib-5.0.0' ; then
		epatch ${FILESDIR}/${P}-t1lib-fix-gentoo.patch
	fi
	cd ${S}
	epatch ${FILESDIR}/${PN}-helpviewer-gentoo.diff
}

src_compile() {

	local gracehelpviewer

	if has_version 'net-www/dillo' ; then
		gracehelpviewer="dillo"
	elif has_version 'net-www/opera' ; then
		gracehelpviewer="opera"
	elif has_version 'net-www/mozilla-firebird' \
		|| has_version 'net-www/mozilla-firebird-bin' \
		|| has_version 'net-www/mozilla-firebird-cvs' ; then
		gracehelpviewer="MozillaFirebird"
	elif has_version 'net-www/mozilla' ; then
		gracehelpviewer="mozilla"
	elif has_version 'kde-base/kdebase' ; then
		gracehelpviewer="konqueror"
	elif has_version 'net-www/galeon' ; then
		gracehelpviewer="galeon"
	elif has_version 'net-www/epiphany' ; then
		gracehelpviewer="epiphany"
	else
		gracehelpviewer="netscape"
	fi

	sed -i -e "s%doc/%/usr/share/doc/${PF}/html/%g" src/*
	sed -i -e "s%examples/%/usr/share/doc/${PF}/examples/%g" src/xmgrace.c

	econf \
		--enable-grace-home=/usr/share/grace \
		--with-helpviewer=${gracehelpviewer} \
		`use_with fftw` \
		`use_enable netcdf` \
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
}
