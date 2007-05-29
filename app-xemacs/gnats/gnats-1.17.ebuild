# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/gnats/gnats-1.17.ebuild,v 1.2 2007/05/29 20:33:26 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="XEmacs bug reports."
PKG_CAT="standard"

RDEPEND="app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

