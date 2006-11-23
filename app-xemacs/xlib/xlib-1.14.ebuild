# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xlib/xlib-1.14.ebuild,v 1.1 2006/11/23 19:25:26 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs interface to X server."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

