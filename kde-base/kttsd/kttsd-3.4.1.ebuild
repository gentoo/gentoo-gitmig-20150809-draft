# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kttsd/kttsd-3.4.1.ebuild,v 1.1 2005/05/25 21:23:12 danarmak Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE text-to-speech subsystem"
KEYWORDS="~x86 ~amd64"
IUSE="gstreamer"
DEPEND="$(deprange $PV $MAXKDEVER kde-base/arts)
	$(deprange-dual $PV $MAXKDEVER kde-base/kcontrol)
	gstreamer? ( >=media-libs/gstreamer-0.8.7 )
	>=dev-util/pkgconfig-0.9.0"

RDEPEND="
|| ( app-accessibility/festival
app-accessibility/epos
app-accessibility/flite
app-accessibility/freetts
)"

myconf="$(use_enable gstreamer kttsd-gstreamer)"

