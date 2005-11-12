# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:25 danarmak Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeadmin - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
$(deprange 3.5_beta1 $MAXKDEVER kde-base/kcron)
$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/kdat)
$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/kdeadmin-kfile-plugins)
$(deprange $PV $MAXKDEVER kde-base/kuser)
x86? ( $(deprange $PV $MAXKDEVER kde-base/lilo-config) )
$(deprange 3.5_beta1 $MAXKDEVER kde-base/secpolicy)"

# NOTE: kpackage, ksysv are useless on a normal gentoo system and so aren't included
# in the above list. However, packages do nominally exist for them.
