# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ruby-modes/ruby-modes-1.01.ebuild,v 1.6 2005/01/01 17:13:53 eradicator Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Ruby support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/debug
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

