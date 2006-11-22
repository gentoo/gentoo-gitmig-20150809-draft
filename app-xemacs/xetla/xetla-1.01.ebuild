# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xetla/xetla-1.01.ebuild,v 1.1 2006/11/22 07:10:12 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION=" Arch (tla) interface for XEmacs"
PKG_CAT="standard"

DEPEND=""
RDEPEND="app-xemacs/ediff
app-xemacs/xemacs-base
app-xemacs/jde
app-xemacs/mail-lib
app-xemacs/dired
app-xemacs/prog-modes
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

