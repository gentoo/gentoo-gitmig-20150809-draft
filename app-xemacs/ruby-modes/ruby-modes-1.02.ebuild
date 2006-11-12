# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ruby-modes/ruby-modes-1.02.ebuild,v 1.1 2006/11/12 12:24:11 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Ruby support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/debug
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

