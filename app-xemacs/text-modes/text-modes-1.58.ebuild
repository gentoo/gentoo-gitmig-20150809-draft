# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/text-modes/text-modes-1.58.ebuild,v 1.2 2003/10/03 02:42:26 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Miscellaneous support for editing text files."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-ispell
app-xemacs/fsf-compat
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

