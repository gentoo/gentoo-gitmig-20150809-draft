# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xemacs-devel/xemacs-devel-1.48.ebuild,v 1.3 2003/02/13 10:00:57 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs Lisp developer support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/ispell
app-xemacs/mail-lib
app-xemacs/gnus
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

