# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/python-modes/python-modes-1.02.ebuild,v 1.6 2005/01/01 17:13:14 eradicator Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Python support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

