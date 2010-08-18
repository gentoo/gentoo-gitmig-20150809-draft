# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/easypg/easypg-1.03.ebuild,v 1.2 2010/08/18 08:55:51 fauli Exp $

inherit xemacs-packages

SLOT="0"
IUSE=""
DESCRIPTION="GnuPG interface for Emacs."
PKG_CAT="standard"

KEYWORDS="~amd64 ~x86"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/dired
app-xemacs/mail-lib
"
