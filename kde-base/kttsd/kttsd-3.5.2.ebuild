# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kttsd/kttsd-3.5.2.ebuild,v 1.1 2006/03/22 20:15:40 danarmak Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE text-to-speech subsystem"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa gstreamer"
DEPEND="media-libs/akode
	alsa? ( media-libs/alsa-lib )
	gstreamer? ( =media-libs/gstreamer-0.8*
	             =media-libs/gst-plugins-0.8* )
	$(deprange-dual $PV $MAXKDEVER kde-base/kcontrol)"

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

	kde-meta_src_compile
}
