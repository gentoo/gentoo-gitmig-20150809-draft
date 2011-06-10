# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/text-modes/text-modes-1.98.ebuild,v 1.2 2011/06/10 17:14:32 jer Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Miscellaneous support for editing text files."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-ispell
app-xemacs/fsf-compat
app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 hppa ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
