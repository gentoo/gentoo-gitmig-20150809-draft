# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/eieio/eieio-1.04.ebuild,v 1.5 2004/06/24 23:11:03 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Enhanced Implementation of Emacs Interpreted Objects"
PKG_CAT="standard"

DEPEND="app-xemacs/speedbar
app-xemacs/xemacs-base
app-xemacs/edebug
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
