# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/strokes/strokes-1.08.ebuild,v 1.7 2004/04/01 01:57:26 jhuebel Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Mouse enhancement utility."
PKG_CAT="standard"

DEPEND="app-xemacs/text-modes
app-xemacs/edit-utils
app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

