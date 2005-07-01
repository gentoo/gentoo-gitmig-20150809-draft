# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-meta/kdeaddons-meta-3.4.1.ebuild,v 1.5 2005/07/01 23:27:06 pylon Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeaddons - merge this to pull in all kdeaddons-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="arts"

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/atlantikdesigner)
$(deprange $PV $MAXKDEVER kde-base/knewsticker-scripts)
$(deprange $PV $MAXKDEVER kde-base/ksig)
$(deprange $PV $MAXKDEVER kde-base/vimpart)
$(deprange $PV $MAXKDEVER kde-base/kaddressbook-plugins)
$(deprange $PV $MAXKDEVER kde-base/kate-plugins)
$(deprange $PV $MAXKDEVER kde-base/kicker-applets)
$(deprange $PV $MAXKDEVER kde-base/kdeaddons-kfile-plugins)
$(deprange $PV $MAXKDEVER kde-base/konq-plugins)
$(deprange $PV $MAXKDEVER kde-base/konqueror-akregator)
$(deprange $PV $MAXKDEVER kde-base/kdeaddons-docs-konq-plugins)
$(deprange $PV $MAXKDEVER kde-base/renamedlg-audio)
$(deprange $PV $MAXKDEVER kde-base/renamedlg-images)
arts? ( $(deprange $PV $MAXKDEVER kde-base/noatun-plugins) )
"

