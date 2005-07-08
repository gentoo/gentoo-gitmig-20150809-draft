# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-meta/kdeartwork-meta-3.4.1.ebuild,v 1.6 2005/07/08 03:29:30 weeve Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeartwork - merge this to pull in all kdeartwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-emoticons)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-iconthemes)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-icewm-themes)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kscreensaver)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kwin-styles)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kworldclock)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-sounds)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-styles)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-wallpapers)
"

