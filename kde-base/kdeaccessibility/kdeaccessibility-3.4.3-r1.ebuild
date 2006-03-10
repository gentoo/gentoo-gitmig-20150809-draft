# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.4.3-r1.ebuild,v 1.11 2006/03/10 13:38:49 agriffis Exp $

inherit kde-dist eutils

DESCRIPTION="KDE accessibility module"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="arts gstreamer"

DEPEND="gstreamer? ( =media-libs/gstreamer-0.8*
	             =media-libs/gst-plugins-0.8* )"

RDEPEND="${DEPEND}
	arts? ( || ( app-accessibility/festival
		     app-accessibility/epos
		     app-accessibility/flite
		     app-accessibility/freetts ) )

	gstreamer? ( || ( app-accessibility/festival
		     app-accessibility/epos
		     app-accessibility/flite ) )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

PATCHES="${FILESDIR}/${P}-pointer.patch"

pkg_setup() {
	kde_pkg_setup
	if use gstreamer; then
		ewarn "gstreamer support in kdeaccessibility is experimental"
	fi
}

src_unpack() {
	kde_src_unpack

	# Make arts optional. Applied for 3.5.
	epatch "${FILESDIR}/kdeaccessibility-3.4.0-noarts.patch"

	# for the noarts patch
	make -f admin/Makefile.common || die
}

src_compile() {
	local myconf="$(use_enable gstreamer kttsd-gstreamer)"

	kde_src_compile
}
