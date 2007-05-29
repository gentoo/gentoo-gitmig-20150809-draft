# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/fortran-modes/fortran-modes-1.05.ebuild,v 1.2 2007/05/29 20:18:06 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Fortran support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages
