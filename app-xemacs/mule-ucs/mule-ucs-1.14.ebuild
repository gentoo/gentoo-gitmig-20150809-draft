# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mule-ucs/mule-ucs-1.14.ebuild,v 1.1 2006/11/12 15:43:20 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Extended coding systems (including Unicode) for XEmacs."
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
app-xemacs/latin-euro-standards
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

