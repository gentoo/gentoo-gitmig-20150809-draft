# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xslide/xslide-1.03.ebuild,v 1.3 2003/02/13 10:01:05 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="XSL editing support."
PKG_CAT="standard"

DEPEND="app-xemacs/ispell
app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

