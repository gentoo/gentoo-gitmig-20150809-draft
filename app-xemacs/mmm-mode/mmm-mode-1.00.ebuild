# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mmm-mode/mmm-mode-1.00.ebuild,v 1.10 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Multiple major modes in a single buffer"
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/fsf-compat
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
