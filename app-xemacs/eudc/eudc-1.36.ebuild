# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/eudc/eudc-1.36.ebuild,v 1.4 2003/02/22 12:46:40 rendhalver Exp $

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
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

