# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/rmail/rmail-1.14.ebuild,v 1.1 2006/11/12 12:22:37 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="An obsolete Emacs mailer."
PKG_CAT="standard"

RDEPEND="app-xemacs/tm
app-xemacs/apel
app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages

