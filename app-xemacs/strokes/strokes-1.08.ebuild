# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/strokes/strokes-1.08.ebuild,v 1.5 2003/10/03 02:41:37 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Mouse enhancement utility."
PKG_CAT="standard"

DEPEND="app-xemacs/text-modes
app-xemacs/edit-utils
app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

