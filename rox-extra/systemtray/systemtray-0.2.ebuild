# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/systemtray/systemtray-0.2.ebuild,v 1.1 2004/12/09 20:09:23 sergey Exp $

DESCRIPTION="SystemTray is a notification area applet for ROX-Filer"

MY_PN="SystemTray"

HOMEPAGE="http://rox.sourceforge.net/"

SRC_URI="mirror://sourceforge/rox/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

ROX_LIB_VER=1.9.10
ROX_CLIB_VER=2.0.0

APPNAME=${MY_PN}

S=${WORKDIR}

inherit rox
