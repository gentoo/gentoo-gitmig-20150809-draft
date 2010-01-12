# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/resolution/resolution-0.3.ebuild,v 1.1 2010/01/12 14:21:17 lack Exp $

ROX_LIB_VER=1.9.3
inherit rox

DESCRIPTION="Change the screen resolution using xrandr"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="x11-apps/xrandr"

APPNAME=Resolution
APPCATEGORY="Settings;HardwareSettings"
