# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/eshell/eshell-1.04.ebuild,v 1.5 2004/06/24 23:11:35 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Command shell implemented entirely in Emacs Lisp"
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/eterm
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
