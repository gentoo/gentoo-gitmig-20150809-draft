# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/auctex/auctex-1.32.ebuild,v 1.6 2004/06/24 23:06:06 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Basic TeX/LaTeX support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages
