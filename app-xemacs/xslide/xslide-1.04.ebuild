# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xslide/xslide-1.04.ebuild,v 1.1 2003/02/22 12:46:41 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="XSL editing support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-ispell
app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

