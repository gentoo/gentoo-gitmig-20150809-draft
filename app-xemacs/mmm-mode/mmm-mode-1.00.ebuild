# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mmm-mode/mmm-mode-1.00.ebuild,v 1.8 2004/06/24 23:16:49 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Multiple major modes in a single buffer"
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/fsf-compat
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

