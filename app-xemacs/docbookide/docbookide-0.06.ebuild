# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/docbookide/docbookide-0.06.ebuild,v 1.5 2004/06/24 23:08:56 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="DocBook editing support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/xemacs-ispell
app-xemacs/mail-lib
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

