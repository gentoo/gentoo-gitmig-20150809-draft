# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xemacs-devel/xemacs-devel-1.50.ebuild,v 1.7 2005/01/01 17:20:44 eradicator Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs Lisp developer support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/xemacs-ispell
app-xemacs/mail-lib
app-xemacs/gnus
app-xemacs/rmail
app-xemacs/tm
app-xemacs/apel
"
KEYWORDS="amd64 x86 ~ppc alpha sparc ppc64"

inherit xemacs-packages

