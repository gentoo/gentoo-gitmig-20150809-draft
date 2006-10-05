# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/resolution/resolution-0.2.ebuild,v 1.2 2006/10/05 03:13:54 lack Exp $


DESCRIPTION="This rox program allows you to change the screen resolution at any time. It is non-permanent"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="http://rox.sourceforge.net/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ROX_LIB_VER=1.9.3

APPNAME=Resolution

inherit rox
