# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pcomplete/pcomplete-1.02.ebuild,v 1.3 2003/02/13 09:56:24 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Provides programmatic completion."
PKG_CAT="standard"

DEPEND="app-xemacs/sh-script
app-xemacs/xemacs-base
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

