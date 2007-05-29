# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/latin-euro-standards/latin-euro-standards-1.07.ebuild,v 1.2 2007/05/29 20:43:26 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Support for the Latin{7,8,9,10} character sets & coding systems."
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

