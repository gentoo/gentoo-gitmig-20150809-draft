# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/edebug/edebug-1.14.ebuild,v 1.3 2003/02/13 09:51:45 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="An Emacs Lisp debugger."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

