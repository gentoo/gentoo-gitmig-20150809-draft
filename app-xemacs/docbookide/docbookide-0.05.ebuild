# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/docbookide/docbookide-0.05.ebuild,v 1.3 2003/02/13 09:51:34 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="DocBook editing support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/ispell
app-xemacs/mail-lib
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

