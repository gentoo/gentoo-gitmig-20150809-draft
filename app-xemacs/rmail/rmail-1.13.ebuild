# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/rmail/rmail-1.13.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="An obsolete Emacs mailer."
PKG_CAT="standard"

DEPEND="app-xemacs/tm
app-xemacs/apel
app-xemacs/mail-lib
app-xemacs/xemacs-base
"

inherit xemacs-packages

