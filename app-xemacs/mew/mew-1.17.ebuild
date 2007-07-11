# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mew/mew-1.17.ebuild,v 1.10 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Messaging in an Emacs World."
PKG_CAT="standard"

DEPEND="app-xemacs/w3
app-xemacs/efs
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/fsf-compat
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
