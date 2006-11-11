# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/dired/dired-1.17.ebuild,v 1.1 2006/11/11 10:14:13 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Manage file systems."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/prog-modes
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
