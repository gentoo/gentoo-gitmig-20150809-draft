# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/edebug/edebug-1.15.ebuild,v 1.5 2004/06/24 23:09:40 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="An Emacs Lisp debugger."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="amd64 x86 ~ppc alpha sparc"

inherit xemacs-packages
