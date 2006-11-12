# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pc/pc-1.28.ebuild,v 1.1 2006/11/12 11:12:21 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="PC style interface emulation."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

