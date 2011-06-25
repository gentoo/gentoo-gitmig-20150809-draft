# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ps-print/ps-print-1.12.ebuild,v 1.3 2011/06/25 18:40:39 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Printing functions and utilities"
PKG_CAT="standard"

RDEPEND="app-xemacs/text-modes
app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 sparc x86"

inherit xemacs-packages
