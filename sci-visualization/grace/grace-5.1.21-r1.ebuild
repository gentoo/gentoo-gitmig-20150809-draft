# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/grace/grace-5.1.21-r1.ebuild,v 1.3 2008/05/03 02:28:12 mabi Exp $

EAPI="1"

inherit eutils fortran autotools

DEB_PR=2

DESCRIPTION="Motif based XY-plotting tool"
HOMEPAGE="http://plasma-gate.weizmann.ac.il/Grace/"
SRC_URI="ftp://plasma-gate.weizmann.ac.il/pub/${PN}/src/stable/${P}.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}-${DEB_PR}.diff.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="fortran fftw jpeg netcdf pdf png"

DEPEND="virtual/motif
	sys-libs/zlib
	media-libs/t1lib
	media-libs/tiff
	x11-libs/xbae
	fftw? ( sci-libs/fftw:2.1 )
	netcdf? ( sci-libs/netcdf )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	pdf? ( media-libs/pdflib )"

RDEPEND="${DEPEND}
	x11-misc/xdg-utils"

pkg_setup() {
	if use fortran; then
		FORTRAN="gfortran g77 ifc"
		fortran_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PR}.diff
	cd "${S}"

	epatch debian/patches/tmpnam_to_mkstemp.diff

	# fix for netcdf versioning in aclocal.m4
	epatch "${FILESDIR}"/${P}-m4-netcdf.patch
	# fix for missing defines when fortran is disabled
	epatch "${FILESDIR}"/${P}-fortran.patch
	# fix for glibc-2.7 (bug #)
	epatch "${FILESDIR}"/${P}-stdc99.patch

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

	# the configure script just produces a basic Make.conf
	# and a config.h

	cp ac-tools/configure.in .
	eautoconf
	eaclocal
}

src_compile() {
	local myconf
	if use fortran; then
		myconf="--with-f77=${FORTRANC}"
	else
		myconf="--without-f77"
	fi

	econf \
		--disable-xmhtml \
		--without-bundled-xbae \
		--without-bundled-t1lib \
		--enable-grace-home=/usr/share/${PN} \
		--with-helpviewer="xdg-open %s" \
		--with-editor="xdg-open %s" \
		--with-printcmd="lpr" \
		$(use_with fftw) \
		$(use_enable fortran f77-wrapper) \
		$(use_enable netcdf) \
		$(use_enable jpeg jpegdrv) \
		$(use_enable png pngdrv) \
		$(use_enable pdf pdfdrv) \
		${myconf} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES ChangeLog DEVELOPERS README COPYRIGHT \
		|| die "dodoc failed"

	dosym ../../${PN}/examples /usr/share/doc/${PF}/examples
	dosym ../../${PN}/doc /usr/share/doc/${PF}/html

	doman debian/fdf2fit.1 || die "doman failed"
	doman "${D}"/usr/share/doc/${PF}/html/*.1
	rm -f "${D}"/usr/share/doc/${PF}/html/*.1
	doicon "${FILESDIR}"/${PN}.png || die "failed installing icon"
	make_desktop_entry xmgrace Grace grace
}
