# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/haskell-mode/haskell-mode-1.03.ebuild,v 1.6 2004/06/24 23:13:43 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Haskell editing support."
PKG_CAT="standard"

DEPEND="app-xemacs/dired
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/edit-utils
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

