# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/devtray/devtray-0.3.3.ebuild,v 1.2 2008/05/11 15:59:24 lack Exp $

ROX_LIB_VER=1.9.6
inherit rox

MY_PN="DevTray"
DESCRIPTION="DevTray is a rox panel applet which shows HAL devices."
HOMEPAGE="http://rox4debian.berlios.de"
SRC_URI="ftp://ftp.berlios.de/pub/rox4debian/apps/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome cddb alsa"

# TODO: When pycups is available, depend on it too (probably conditionally)

RDEPEND="<rox-base/traylib-0.3
	dev-python/dbus-python
	sys-apps/hal
	cddb? ( dev-python/cddb-py )
	alsa? ( dev-python/pyalsaaudio )
	gnome? ( >=dev-python/gnome-python-desktop-2.12 )"

APPNAME="${MY_PN}"
S="${WORKDIR}"
