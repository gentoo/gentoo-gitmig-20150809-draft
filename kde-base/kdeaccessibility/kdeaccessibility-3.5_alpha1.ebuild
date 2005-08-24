# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.5_alpha1.ebuild,v 1.1 2005/08/24 23:10:17 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE accessibility module"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="alsa gstreamer"

DEPEND="alsa? ( media-libs/alsa-lib )
	gstreamer? ( >=media-libs/gstreamer-0.8.7
	             >=media-libs/gst-plugins-0.8.7 )"

RDEPEND="${DEPEND}
	|| ( app-accessibility/festival
	     app-accessibility/epos
	     app-accessibility/flite
	     app-accessibility/freetts )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf="$(use_with alsa) $(use_with gstreamer)"

	# Compile without akode support until there's a
	# standalone release of akode.
	myconf="${myconf} --without-akode"

	kde_src_compile
}
