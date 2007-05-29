# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/lookup/lookup-1.15.ebuild,v 1.2 2007/05/29 20:48:08 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Dictionary support"
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
app-xemacs/cookie
"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

