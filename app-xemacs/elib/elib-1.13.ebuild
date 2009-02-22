# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/elib/elib-1.13.ebuild,v 1.1 2009/02/22 13:37:20 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Portable Emacs Lisp utilities library."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
