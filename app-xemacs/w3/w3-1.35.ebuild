# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/w3/w3-1.35.ebuild,v 1.4 2011/06/28 21:43:10 ranger Exp $

SLOT="0"
IUSE=""
DESCRIPTION="A Web browser."
PKG_CAT="standard"

RDEPEND="app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/ecrypto
"
KEYWORDS="alpha ~amd64 ppc ~ppc64 sparc x86"

inherit xemacs-packages
