# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/eterm/eterm-1.13.ebuild,v 1.3 2003/02/13 09:52:47 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Terminal emulation."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

