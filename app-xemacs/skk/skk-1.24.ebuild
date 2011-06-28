# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/skk/skk-1.24.ebuild,v 1.4 2011/06/28 21:43:18 ranger Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Japanese Language Input Method."
PKG_CAT="mule"

RDEPEND="app-xemacs/viper
app-xemacs/mule-base
app-xemacs/elib
app-xemacs/xemacs-base
app-xemacs/apel
"
KEYWORDS="alpha ~amd64 ppc ~ppc64 sparc x86"

inherit xemacs-packages
