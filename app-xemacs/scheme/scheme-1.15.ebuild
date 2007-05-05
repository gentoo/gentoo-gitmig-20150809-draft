# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/scheme/scheme-1.15.ebuild,v 1.1 2007/05/05 07:17:37 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Front-end support for Inferior Scheme."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

