# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/texinfo/texinfo-1.23.ebuild,v 1.2 2003/10/03 02:42:11 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="XEmacs TeXinfo support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

