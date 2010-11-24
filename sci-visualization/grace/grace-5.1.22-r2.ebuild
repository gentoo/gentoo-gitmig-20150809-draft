# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/grace/grace-5.1.22-r2.ebuild,v 1.4 2010/11/24 20:52:12 bicatali Exp $

EAPI=3
inherit eutils toolchain-funcs

DESCRIPTION="Motif based XY-plotting tool"
HOMEPAGE="http://plasma-gate.weizmann.ac.il/Grace/"
SRC_URI="ftp://plasma-gate.weizmann.ac.il/pub/${PN}/src/stable/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="fortran fftw jpeg netcdf pdf png"

DEPEND=">=x11-libs/openmotif-2.3:0
	sys-libs/zlib
	media-libs/t1lib
	media-libs/tiff
	x11-libs/xbae
	fftw? ( sci-libs/fftw:2.1 )
	netcdf? ( sci-libs/netcdf )
	png? ( media-libs/libpng )
	jpeg? ( virtual/jpeg )
	pdf? ( media-libs/pdflib )"

RDEPEND="${DEPEND}
	x11-misc/xdg-utils"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	# move tmpnam to mkstemp (adapted from debian)
	epatch "${FILESDIR}"/${P}-mkstemp.patch
	# fix configure instead of aclocal.m4
	epatch "${FILESDIR}"/${PN}-5.1.21-netcdf.patch
	# fix for missing defines when fortran is disabled
	epatch "${FILESDIR}"/${PN}-5.1.21-fortran.patch
	# fix a leak and pdf driver (from freebsd)
	epatch "${FILESDIR}"/${P}-dlmodule.patch
	epatch "${FILESDIR}"/${P}-pdfdrv.patch \
		"${FILESDIR}"/${P}-ldflags.patch

	# don't strip if not asked for
	sed -i \
		-e 's:$(INSTALL_PROGRAM) -s:$(INSTALL_PROGRAM):g' \
		{auxiliary,grconvert,src}/Makefile

	sed -i \
		-e 's:$(GRACE_HOME)/bin:$(PREFIX)/bin:g' \
		-e "s:\$(GRACE_HOME)/lib:\$(PREFIX)/$(get_libdir):g" \
		-e 's:$(GRACE_HOME)/include:$(PREFIX)/include:g' \
		-e 's:$(PREFIX)/man:$(PREFIX)/share/man:g' \
		Makefile */Makefile || die "sed failed"

	sed -i \
		-e 's:bin/grconvert:grconvert:' \
		-e 's:auxiliary/fdf2fit:fdf2fit:' \
		gracerc || die
}

src_configure() {
	local myconf
	if use fortran; then
		myconf="--with-f77=$(tc-getFC)"
	else
		myconf="--without-f77"
	fi

	# the configure script just produces a basic Make.conf
	# and a config.h
	econf \
		--disable-xmhtml \
		--without-bundled-xbae \
		--without-bundled-t1lib \
		--enable-grace-home="${EPREFIX}"/usr/share/${PN} \
		--with-helpviewer="xdg-open %s" \
		--with-editor="xdg-open %s" \
		--with-printcmd="lpr" \
		$(use_with fftw) \
		$(use_enable fortran f77-wrapper) \
		$(use_enable netcdf) \
		$(use_enable jpeg jpegdrv) \
		$(use_enable png pngdrv) \
		$(use_enable pdf pdfdrv) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGES ChangeLog DEVELOPERS README || die

	dosym ../../${PN}/examples /usr/share/doc/${PF}/examples
	dosym ../../${PN}/doc /usr/share/doc/${PF}/html

	doman "${ED}"/usr/share/doc/${PF}/html/*.1
	rm -f "${ED}"/usr/share/doc/${PF}/html/*.1
	doicon "${FILESDIR}"/${PN}.png || die
	make_desktop_entry xmgrace Grace grace
}
