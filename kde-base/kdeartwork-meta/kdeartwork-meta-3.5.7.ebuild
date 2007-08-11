# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-meta/kdeartwork-meta-3.5.7.ebuild,v 1.8 2007/08/11 15:11:44 armin76 Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeartwork - merge this to pull in all kdeartwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="
$(deprange 3.5.4 $MAXKDEVER kde-base/kdeartwork-emoticons)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-iconthemes)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-icewm-themes)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kscreensaver)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kwin-styles)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kworldclock)
$(deprange 3.5.6 $MAXKDEVER kde-base/kdeartwork-sounds)
$(deprange $PV $MAXKDEVER kde-base/kdeartwork-styles)
$(deprange 3.5.6 $MAXKDEVER kde-base/kdeartwork-wallpapers)
"
