# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-meta/kdeaddons-meta-3.4.0_rc1.ebuild,v 1.1 2005/02/27 20:21:32 danarmak Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeaddons - merge this to pull in all kdeaddons-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="~x86"
IUSE="arts"

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/atlantikdesigner)
$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/knewsticker-scripts)
$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/ksig)
$(deprange $PV $MAXKDEVER kde-base/vimpart)
$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/kaddressbook-plugins)
$(deprange $PV $MAXKDEVER kde-base/kate-plugins)
$(deprange $PV $MAXKDEVER kde-base/kicker-applets)
$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/kdeaddons-kfile-plugins)
$(deprange $PV $MAXKDEVER kde-base/konqueror-akregator)
$(deprange $PV $MAXKDEVER kde-base/kdeaddons-docs-konq-plugins)
$(deprange $PV $MAXKDEVER kde-base/renamedlg-audio)
$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/renamedlg-images)
arts? ( $(deprange $PV $MAXKDEVER kde-base/noatun-plugins) )
"

