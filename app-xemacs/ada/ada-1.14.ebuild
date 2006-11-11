# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ada/ada-1.14.ebuild,v 1.1 2006/11/11 08:58:16 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Ada language support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages
