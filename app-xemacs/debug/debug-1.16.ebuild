# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/debug/debug-1.16.ebuild,v 1.7 2004/03/31 23:52:54 jhuebel Exp $

SLOT="0"
IUSE=""
DESCRIPTION="GUD, gdb, dbx debugging support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
