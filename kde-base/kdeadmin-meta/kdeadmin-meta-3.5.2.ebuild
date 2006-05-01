# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-3.5.2.ebuild,v 1.3 2006/05/01 14:46:10 carlo Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeadmin - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="$(deprange 3.5.1 $MAXKDEVER kde-base/kcron)
	$(deprange 3.5.1 $MAXKDEVER kde-base/kdeadmin-kfile-plugins)
	$(deprange $PV $MAXKDEVER kde-base/kuser)
	x86? ( $(deprange 3.5.1 $MAXKDEVER kde-base/lilo-config) )
	amd64? ( $(deprange 3.5.1 $MAXKDEVER kde-base/lilo-config) )
	$(deprange 3.5.0 $MAXKDEVER kde-base/secpolicy)"

# NOTE: KPackage, KSysv are useless on a normal gentoo system and so aren't included
# in the above list. KDat is broken and unmaintained. However, packages do nominally 
# exist for them.

