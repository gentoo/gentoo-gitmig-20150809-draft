# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pc/pc-1.25.ebuild,v 1.5 2003/10/03 02:33:16 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="PC style interface emulation."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

