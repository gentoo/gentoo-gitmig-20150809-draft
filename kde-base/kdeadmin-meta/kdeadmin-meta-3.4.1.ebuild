# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-3.4.1.ebuild,v 1.5 2005/07/01 23:30:32 pylon Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeadmin - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/kcron)
$(deprange $PV $MAXKDEVER kde-base/kdat)
$(deprange $PV $MAXKDEVER kde-base/kdeadmin-kfile-plugins)
$(deprange $PV $MAXKDEVER kde-base/kuser)
x86? ( $(deprange $PV $MAXKDEVER kde-base/lilo-config) )
$(deprange $PV $MAXKDEVER kde-base/secpolicy)"

# NOTE: kpackage, ksysv are useless on a normal gentoo system and so aren't included
# in the above list. However, packages do nominally exist for them.
