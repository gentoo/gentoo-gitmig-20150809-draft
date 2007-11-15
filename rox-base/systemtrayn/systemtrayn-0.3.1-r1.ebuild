# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/systemtrayn/systemtrayn-0.3.1-r1.ebuild,v 1.4 2007/11/15 20:20:14 drac Exp $

ROX_CLIB_VER=2.1.7
inherit rox

MY_PN="SystemTrayN"
DESCRIPTION="SystemTrayN is an updated notification area applet for ROX-Filer"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/systemtrayn.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

APPNAME=${MY_PN}
S=${WORKDIR}
