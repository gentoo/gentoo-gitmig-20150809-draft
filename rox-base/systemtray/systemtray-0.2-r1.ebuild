# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/systemtray/systemtray-0.2-r1.ebuild,v 1.1 2005/10/03 18:57:50 svyatogor Exp $

MY_PN="SystemTray"
DESCRIPTION="SystemTray is a notification area applet for ROX-Filer"
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
SET_PERM=true

inherit rox
