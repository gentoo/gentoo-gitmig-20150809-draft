# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/psgml/psgml-1.38.ebuild,v 1.7 2005/01/01 17:12:35 eradicator Exp $

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
app-xemacs/xemacs-eterm
app-xemacs/sh-script
app-xemacs/ps-print
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

