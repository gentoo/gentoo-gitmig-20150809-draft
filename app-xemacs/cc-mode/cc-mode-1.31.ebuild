# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/cc-mode/cc-mode-1.31.ebuild,v 1.6 2004/06/24 23:07:11 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="C, C++ and Java language support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages
