# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/skk/skk-1.24.ebuild,v 1.1 2009/02/22 07:57:24 graaff Exp $

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
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
