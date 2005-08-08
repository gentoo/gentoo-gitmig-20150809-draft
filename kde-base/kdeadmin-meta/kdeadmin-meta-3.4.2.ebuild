# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-3.4.2.ebuild,v 1.2 2005/08/08 21:15:35 kloeri Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeadmin - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="
$(deprange 3.4.1 $MAXKDEVER kde-base/kcron)
$(deprange 3.4.1 $MAXKDEVER kde-base/kdat)
$(deprange $PV $MAXKDEVER kde-base/kdeadmin-kfile-plugins)
$(deprange $PV $MAXKDEVER kde-base/kuser)
x86? ( $(deprange 3.4.1 $MAXKDEVER kde-base/lilo-config) )
$(deprange 3.4.1 $MAXKDEVER kde-base/secpolicy)"

# NOTE: kpackage, ksysv are useless on a normal gentoo system and so aren't included
# in the above list. However, packages do nominally exist for them.
