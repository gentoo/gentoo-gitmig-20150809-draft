# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kttsd/kttsd-3.4.0.ebuild,v 1.2 2005/03/18 16:49:42 morfic Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE text-to-speech subsystem"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="gstreamer"
DEPEND="$(deprange $PV $MAXKDEVER kde-base/arts)
	$(deprange $PV $MAXKDEVER kde-base/kcontrol)
	gstreamer? ( >=media-libs/gstreamer-0.8.7 )
	>=dev-util/pkgconfig-0.9.0"

RDEPEND="
|| ( app-accessibility/festival
app-accessibility/epos
app-accessibility/flite
app-accessibility/freetts
)"

myconf="$(use_enable gstreamer kttsd-gstreamer)"

