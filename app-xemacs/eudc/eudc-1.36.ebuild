# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/eudc/eudc-1.36.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs Unified Directory Client (LDAP, PH)."
PKG_CAT="standard"

DEPEND="app-xemacs/fsf-compat
app-xemacs/xemacs-base
app-xemacs/bbdb
app-xemacs/mail-lib
app-xemacs/gnus
"

inherit xemacs-packages

