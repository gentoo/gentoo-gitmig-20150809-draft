# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/psgml-dtds/psgml-dtds-1.02.ebuild,v 1.8 2004/06/24 23:19:16 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Deprecated collection of DTDs for psgml."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/psgml
app-xemacs/edit-utils
app-xemacs/mail-lib
app-xemacs/fsf-compat
app-xemacs/eterm
app-xemacs/sh-script
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

