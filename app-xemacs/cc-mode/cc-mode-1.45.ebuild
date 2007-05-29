# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/cc-mode/cc-mode-1.45.ebuild,v 1.2 2007/05/29 18:04:32 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="C, C++ and Java language support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
