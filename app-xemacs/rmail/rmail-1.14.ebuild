# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/rmail/rmail-1.14.ebuild,v 1.2 2007/05/29 21:37:46 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="An obsolete Emacs mailer."
PKG_CAT="standard"

RDEPEND="app-xemacs/tm
app-xemacs/apel
app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages

