# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.4.3-r4.ebuild,v 1.9 2006/03/24 05:27:04 agriffis Exp $

inherit kde-dist eutils

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="gphoto2 imlib nodrm openexr opengl povray scanner tetex"

DEPEND="~kde-base/kdebase-${PV}
	>=media-libs/freetype-2
	media-libs/fontconfig
	gphoto2? ( media-libs/libgphoto2 )
	scanner? ( media-gfx/sane-backends )
	media-libs/libart_lgpl
	media-libs/lcms
	dev-libs/fribidi
	imlib? ( media-libs/imlib )
	virtual/ghostscript
	media-libs/tiff
	openexr? ( >=media-libs/openexr-1.2 )
	povray? ( media-gfx/povray
		  virtual/opengl )"

RDEPEND="${DEPEND}
	|| ( >=app-text/poppler-bindings-0.4.3-r1
	     <app-text/xpdf-3.01-r4 )
	tetex? (
	|| ( >=app-text/tetex-2
	     app-text/ptex
	     app-text/cstetex
	     app-text/dvipdfm ) )"
# kfile-plugins/pdf depends on "pdfinfo"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use app-text/poppler-bindings qt; then
		eerror "This package requires app-text/poppler-bindings compiled with Qt support."
		eerror "Please reemerge app-text/poppler-bindings with USE=\"qt\"."
		die "Please reemerge app-text/poppler-bindings with USE=\"qt\"."
	fi
}

src_unpack() {
	kde_src_unpack

	# Fix detection of gocr (kde bug 90082).
	epatch "${FILESDIR}/kdegraphics-3.4.1-gocr.patch"

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdegraphics-3.4-configure.patch"

	epatch "${FILESDIR}/post-3.4.3-kdegraphics-CAN-2005-3193.diff"

	epatch "${FILESDIR}/post-3.4.3-kdegraphics-CVE-2006-0301.diff"

	# For the configure patch.
	make -f admin/Makefile.common || die
}

src_compile() {
	if use gphoto2; then
		myconf="${myconf} --with-kamera \
				  --with-gphoto2-includes=/usr/include/gphoto2 \
				  --with-gphoto2-libraries=/usr/lib/gphoto2"
	else
		myconf="${myconf} --without-kamera"
	fi

	use scanner || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kooka libkscan"
	use povray || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kpovmodeler"

	myconf="${myconf} $(use_with imlib) $(use_enable !nodrm kpdf-drm)
		$(use_with openexr)"

	kde_src_compile
}
