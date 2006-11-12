# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/vc-cc/vc-cc-1.22.ebuild,v 1.1 2006/11/12 14:32:15 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Version Control for ClearCase (UnFree) systems."
PKG_CAT="standard"

RDEPEND="app-xemacs/dired
app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

