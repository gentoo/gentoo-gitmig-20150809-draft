# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-3.4.3.ebuild,v 1.9 2006/03/25 15:05:40 agriffis Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeadmin - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/kcron)
$(deprange $PV $MAXKDEVER kde-base/kdat)
$(deprange 3.4.2 $MAXKDEVER kde-base/kdeadmin-kfile-plugins)
$(deprange 3.4.2 $MAXKDEVER kde-base/kuser)
x86? ( $(deprange 3.4.1 $MAXKDEVER kde-base/lilo-config) )
$(deprange 3.4.1 $MAXKDEVER kde-base/secpolicy)"

# NOTE: kpackage, ksysv are useless on a normal gentoo system and so aren't included
# in the above list. However, packages do nominally exist for them.
