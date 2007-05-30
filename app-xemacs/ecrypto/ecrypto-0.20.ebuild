# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ecrypto/ecrypto-0.20.ebuild,v 1.2 2007/05/30 13:21:30 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Crypto functionality in Emacs Lisp."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
