# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/dired/dired-1.12.ebuild,v 1.3 2003/02/13 09:51:29 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Manage file systems."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/prog-modes
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

