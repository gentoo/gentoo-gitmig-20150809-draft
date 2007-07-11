# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pc/pc-1.25.ebuild,v 1.11 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="PC style interface emulation."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ppc alpha sparc amd64"

inherit xemacs-packages
