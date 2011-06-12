# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ibuffer/ibuffer-1.10.ebuild,v 1.2 2011/06/12 04:15:11 tomka Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Advanced replacement for buffer-menu"
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"

inherit xemacs-packages
