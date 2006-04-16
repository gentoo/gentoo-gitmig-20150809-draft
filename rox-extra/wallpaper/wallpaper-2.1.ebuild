# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/wallpaper/wallpaper-2.1.ebuild,v 1.1 2006/04/16 12:38:44 svyatogor Exp $

DESCRIPTION="Wallpaper - For setting the backdrop for the ROX Desktop"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

ROX_LIB_VER=1.9.8
APPNAME=Wallpaper

inherit rox
