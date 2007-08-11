# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.5.7.ebuild,v 1.8 2007/08/11 14:45:15 armin76 Exp $

inherit kde-dist

DESCRIPTION="KDE accessibility module"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE="alsa gstreamer"

DEPEND="media-libs/akode
	alsa? ( media-libs/alsa-lib )
	gstreamer? ( =media-libs/gstreamer-0.8*
				=media-libs/gst-plugins-0.8* )"

RDEPEND="${DEPEND}
	|| ( app-accessibility/festival
		app-accessibility/epos
		app-accessibility/flite
		app-accessibility/freetts )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf="--with-akode
				$(use_with alsa) $(use_with gstreamer)"

	kde_src_compile
}

pkg_postinst() {
	kde_pkg_postinst
	echo
	elog "${P} has some optional dependencies which you might want to emerge:"
	elog "- app-accessibility/festival to enable the Festival text to speech engine."
	elog "- app-accessibility/epos to enable the epos text to speech engine."
	elog "- app-accessibility/flite to enable the Flite text to speech engine."
	elog "- app-accessibility/freetts for enabling the freetts text to speech engine."
	echo
}
