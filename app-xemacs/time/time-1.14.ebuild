# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/time/time-1.14.ebuild,v 1.2 2007/05/29 21:55:36 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Display time & date on the modeline."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages

