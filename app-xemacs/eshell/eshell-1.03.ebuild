# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/eshell/eshell-1.03.ebuild,v 1.2 2003/01/16 15:12:53 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Command shell implemented entirely in Emacs Lisp"
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/eterm
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

