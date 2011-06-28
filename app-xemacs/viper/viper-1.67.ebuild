# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/viper/viper-1.67.ebuild,v 1.4 2011/06/28 21:43:15 ranger Exp $

SLOT="0"
IUSE=""
DESCRIPTION="VI emulation support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ppc ~ppc64 sparc x86"

inherit xemacs-packages
