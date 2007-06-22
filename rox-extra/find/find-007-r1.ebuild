# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/find/find-007-r1.ebuild,v 1.2 2007/06/22 21:57:13 lack Exp $

ROX_LIB_VER=2.0.0
inherit rox

MY_PN="Find"
DESCRIPTION="Find - A file Finder utility for ROX by Ken Hayber."
HOMEPAGE="http://www.hayber.us/rox/Find"
SRC_URI="http://www.hayber.us/rox/find/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

APPNAME=${MY_PN}
APPCATEGORY="Utility"
S=${WORKDIR}

