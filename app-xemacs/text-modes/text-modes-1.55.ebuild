# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/text-modes/text-modes-1.55.ebuild,v 1.1 2002/12/16 12:22:48 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Miscellaneous support for editing text files."
PKG_CAT="standard"

DEPEND="app-xemacs/ispell
app-xemacs/fsf-compat
app-xemacs/xemacs-base
"

inherit xemacs-packages

