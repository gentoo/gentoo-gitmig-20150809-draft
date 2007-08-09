# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/grace/grace-5.1.21.ebuild,v 1.1 2007/08/09 21:26:47 je_fro Exp $

inherit eutils

DESCRIPTION="WYSIWYG 2D plotting tool for the X Window System"
HOMEPAGE="http://plasma-gate.weizmann.ac.il/Grace/"
SRC_URI="ftp://plasma-gate.weizmann.ac.il/pub/grace/src/stable/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug fftw jpeg netcdf pdf png"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="virtual/motif
	>=sys-libs/zlib-1.0.3
	>=media-libs/t1lib-1.3.1
	>=media-libs/tiff-3.5
	fftw?	( =sci-libs/fftw-2* )
	netcdf?	( >=sci-libs/netcdf-3.0 )
	png?	( >=media-libs/libpng-0.9.6 )
	jpeg?	( media-libs/jpeg )
	pdf?	( >=media-libs/pdflib-4.0.3 )"

DEPEND="${RDEPEND}
		>=sys-apps/sed-4"

src_compile() {

	local gracehelpviewer
	local graceeditor

	if has_version 'www-client/dillo' ; then
		gracehelpviewer="dillo"
	elif has_version 'www-client/opera' ; then
		gracehelpviewer="opera"
	elif has_version 'www-client/mozilla-firefox' \
		|| has_version 'www-client/mozilla-firefox-bin' \
		|| has_version 'www-client/mozilla-firefox-cvs' ; then
		gracehelpviewer="firefox"
	elif has_version 'www-client/mozilla' ; then
		gracehelpviewer="mozilla"
	elif has_version 'kde-base/kdebase' \
		|| has_version 'kde-base/konqueror' ; then
		gracehelpviewer="konqueror"
	elif has_version 'www-client/galeon' ; then
		gracehelpviewer="galeon"
	elif has_version 'www-client/epiphany' ; then
		gracehelpviewer="epiphany"
	else
		gracehelpviewer="netscape"
	fi

	graceeditor="xterm -e ${EDITOR}"

	sed -i -e "s%doc/%/usr/share/doc/${PF}/html/%g" src/*
	sed -i -e "s%examples/%/usr/share/doc/${PF}/examples/%g" src/xmgrace.c

	econf \
		--enable-grace-home=/usr/share/grace \
		--with-helpviewer="${gracehelpviewer} %s" \
		--with-editor="${graceeditor}" \
		`use_with fftw` \
		`use_enable netcdf` \
		`use_enable debug` \
		`use_enable jpeg jpegdrv` \
		`use_enable png pngdrv` \
		`use_enable pdf pdfdrv` || die

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
		GRACE_HOME="${D}/usr/share/grace" \
		PREFIX="${D}/usr" \
		install || die

	dodoc CHANGES COPYRIGHT ChangeLog DEVELOPERS LICENSE README

	doman "${D}"/usr/share/doc/${PF}/html/*.1
	rm -f "${D}"/usr/share/doc/${PF}/html/*.1

	dosym /usr/share/doc/${PF}/examples /usr/share/grace/examples

	insinto /usr/share/pixmaps/
	doins ${FILESDIR}/${PN}.png

	insinto /usr/share/applications/
	doins ${FILESDIR}/${PN}.desktop

	into /usr/
	dobin ${FILESDIR}/xm${PN}.sh

}
