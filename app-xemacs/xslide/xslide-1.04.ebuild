# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xslide/xslide-1.04.ebuild,v 1.6 2004/06/24 23:26:05 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="XSL editing support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-ispell
app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

