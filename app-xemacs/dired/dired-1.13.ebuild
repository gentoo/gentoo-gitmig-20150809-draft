# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/dired/dired-1.13.ebuild,v 1.1 2003/02/22 12:46:39 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Manage file systems."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/prog-modes
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

