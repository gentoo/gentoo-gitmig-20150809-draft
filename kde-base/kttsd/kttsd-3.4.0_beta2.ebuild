# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kttsd/kttsd-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:25 danarmak Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE text-to-speech subsystem"
KEYWORDS="~x86"
IUSE="gstreamer"
DEPEND="$(deprange $PV $MAXKDEVER kde-base/arts)
	$(deprange $PV $MAXKDEVER kde-base/kcontrol)
	gstreamer? ( >=media-libs/gstreamer-0.8.7 )
	>=dev-util/pkgconfig-0.9.0"

RDEPEND="
|| ( app-accessibility/festival
app-accessibility/flite
app-accessibility/freetts
app-accessibility/epos
)"

myconf="$(use_enable gstreamer kttsd-gstreamer)"

# Couldn't get festival client/server mode to work, but then I didn't try very hard
# myconf:	$(use_enable festival kttsd-festivalcs)"


# The Festival engine plugin (not festivalint and festivalcs) doesn't compile,
# as gentoo's festival ebuild doesn't install libFestival.a.
# DEPEND:	festival? ( app-accessibility/festival app-accessibility/speech-tools )"
# myconf:	$(use_enable festival kttsd-festival)
#		$(use_with festival speech_tools-includes /usr/lib/speech-tools/include)

