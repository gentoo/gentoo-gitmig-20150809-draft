# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.4.2.ebuild,v 1.1 2005/07/28 12:59:54 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE accessibility module"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="arts gstreamer"

DEPEND="gstreamer? ( >=media-libs/gstreamer-0.8.7
	             >=media-libs/gst-plugins-0.8.7 )"

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
}

src_compile() {
	local myconf="$(use_enable gstreamer kttsd-gstreamer)"

	kde_src_compile
}
