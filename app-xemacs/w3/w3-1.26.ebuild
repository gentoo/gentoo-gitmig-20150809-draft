# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/w3/w3-1.26.ebuild,v 1.6 2004/06/24 23:25:12 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="A Web browser."
PKG_CAT="standard"

DEPEND="app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/ecrypto
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

