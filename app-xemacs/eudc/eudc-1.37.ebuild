# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/eudc/eudc-1.37.ebuild,v 1.5 2004/06/24 23:12:06 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs Unified Directory Client (LDAP, PH)."
PKG_CAT="standard"

DEPEND="app-xemacs/fsf-compat
app-xemacs/xemacs-base
app-xemacs/bbdb
app-xemacs/mail-lib
app-xemacs/gnus
app-xemacs/rmail
app-xemacs/tm
app-xemacs/apel
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
