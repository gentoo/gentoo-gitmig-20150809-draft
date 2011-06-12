# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/locale/locale-1.28.ebuild,v 1.2 2011/06/12 04:19:46 tomka Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Localized menubars and localized splash screens."
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"

inherit xemacs-packages
