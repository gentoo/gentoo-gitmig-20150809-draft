# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.5.9.ebuild,v 1.2 2008/05/11 17:27:04 corsair Exp $

EAPI="1"
inherit kde-dist

DESCRIPTION="KDE accessibility module"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ppc64 ~sparc ~x86"
IUSE="alsa"

DEPEND="media-libs/akode
	alsa? ( media-libs/alsa-lib )"

RDEPEND="${DEPEND}
	|| ( app-accessibility/festival
		app-accessibility/epos
		app-accessibility/flite
		app-accessibility/freetts )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf="--with-akode
		$(use_with alsa)
		--without-gstreamer"

	# Fix the desktop file.
	sed -i -e "s:MimeTypes=:MimeType=:" ./kttsd/kttsmgr/kttsmgr.desktop

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
