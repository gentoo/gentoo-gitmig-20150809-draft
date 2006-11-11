# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/debug/debug-1.17.ebuild,v 1.1 2006/11/11 14:01:57 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="GUD, gdb, dbx debugging support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
