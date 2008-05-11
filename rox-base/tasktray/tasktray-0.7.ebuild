# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/tasktray/tasktray-0.7.ebuild,v 1.1 2008/05/11 16:00:23 lack Exp $

ROX_LIB_VER=1.9.6
inherit rox

MY_PN="TaskTray"
DESCRIPTION="TaskTray is a rox panel applet to show running applications."
HOMEPAGE="http://rox4debian.berlios.de"
SRC_URI="ftp://ftp.berlios.de/pub/rox4debian/apps/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-python/gnome-python-desktop-2.12
	>=rox-base/traylib-0.3.2.1"

APPNAME="${MY_PN}"
S="${WORKDIR}"
