# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/edt/edt-1.12.ebuild,v 1.8 2004/06/24 23:10:21 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="DEC EDIT/EDT emulation."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
