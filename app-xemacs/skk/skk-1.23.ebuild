# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/skk/skk-1.23.ebuild,v 1.8 2004/06/24 23:21:21 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Japanese Language Input Method."
PKG_CAT="mule"

DEPEND="app-xemacs/viper
app-xemacs/mule-base
app-xemacs/elib
app-xemacs/xemacs-base
app-xemacs/apel
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

