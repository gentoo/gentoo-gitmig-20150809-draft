# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/text-modes/text-modes-1.55.ebuild,v 1.6 2004/06/24 23:22:55 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Miscellaneous support for editing text files."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-ispell
app-xemacs/fsf-compat
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

