# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/dired/dired-1.13.ebuild,v 1.6 2004/08/10 02:37:53 tgall Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Manage file systems."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/prog-modes
"
KEYWORDS="amd64 x86 ~ppc alpha sparc ppc64"

inherit xemacs-packages
