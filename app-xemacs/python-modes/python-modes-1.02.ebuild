# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/python-modes/python-modes-1.02.ebuild,v 1.1 2003/02/22 12:46:40 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Python support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

