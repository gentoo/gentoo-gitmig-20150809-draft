# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/vc-cc/vc-cc-1.21.ebuild,v 1.9 2005/01/01 17:19:08 eradicator Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Version Control for ClearCase (UnFree) systems."
PKG_CAT="standard"

DEPEND="app-xemacs/dired
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

