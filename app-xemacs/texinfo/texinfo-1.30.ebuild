# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/texinfo/texinfo-1.30.ebuild,v 1.1 2006/11/12 13:59:55 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="XEmacs TeXinfo support."
PKG_CAT="standard"

RDEPEND="app-xemacs/text-modes
app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

