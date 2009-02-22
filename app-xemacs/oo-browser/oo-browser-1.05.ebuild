# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/oo-browser/oo-browser-1.05.ebuild,v 1.1 2009/02/22 09:38:10 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="The Multi-Language Object-Oriented Code Browser."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/hyperbole
app-xemacs/gnus
app-xemacs/sh-script
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
