# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/rmail/rmail-1.13.ebuild,v 1.10 2005/01/01 17:13:39 eradicator Exp $

SLOT="0"
IUSE=""
DESCRIPTION="An obsolete Emacs mailer."
PKG_CAT="standard"

DEPEND="app-xemacs/tm
app-xemacs/apel
app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="amd64 x86 ~ppc alpha sparc ppc64"

inherit xemacs-packages

