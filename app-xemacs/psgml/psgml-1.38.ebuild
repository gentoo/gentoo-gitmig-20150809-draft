# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/psgml/psgml-1.38.ebuild,v 1.5 2004/06/24 23:19:06 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Validated HTML/SGML editing."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/edit-utils
app-xemacs/edebug
app-xemacs/xemacs-devel
app-xemacs/mail-lib
app-xemacs/fsf-compat
app-xemacs/eterm
app-xemacs/sh-script
app-xemacs/ps-print
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

