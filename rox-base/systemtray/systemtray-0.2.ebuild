# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/systemtray/systemtray-0.2.ebuild,v 1.1 2004/11/27 10:49:17 sergey Exp $

DESCRIPTION="SystemTray is a notification area applet for ROX-Filer"

MY_PN="SystemTray"

HOMEPAGE="http://home.comcast.net/~andyhanton/software/"

SRC_URI="http://home.comcast.net/~andyhanton/software/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

ROX_LIB_VER=1.9.10
ROX_CLIB_VER=2.0.0

APPNAME=${MY_PN}

S=${WORKDIR}

inherit rox
