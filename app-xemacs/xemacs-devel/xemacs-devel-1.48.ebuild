# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xemacs-devel/xemacs-devel-1.48.ebuild,v 1.1 2002/12/16 12:22:48 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs Lisp developer support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/ispell
app-xemacs/mail-lib
app-xemacs/gnus
"

inherit xemacs-packages

