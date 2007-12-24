# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/debug/debug-1.18.ebuild,v 1.5 2007/12/24 02:36:06 jer Exp $

SLOT="0"
IUSE=""
DESCRIPTION="GUD, gdb, dbx debugging support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"

inherit xemacs-packages
