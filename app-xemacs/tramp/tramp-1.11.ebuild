# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/tramp/tramp-1.11.ebuild,v 1.7 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Remote shell-based file editing."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/vc
app-xemacs/fsf-compat
app-xemacs/efs
app-xemacs/dired
app-xemacs/mail-lib
app-xemacs/gnus
app-xemacs/ediff
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
