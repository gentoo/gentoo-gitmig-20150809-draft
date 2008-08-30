# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/weather/weather-0.3.1.ebuild,v 1.4 2008/08/30 20:06:34 maekke Exp $

ROX_LIB_VER=1.9.6
inherit rox

MY_PN="Weather"
DESCRIPTION="Weather is a panel applet for Rox"
HOMEPAGE="http://rox4debian.berlios.de"
SRC_URI="ftp://ftp.berlios.de/pub/rox4debian/apps/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

APPNAME="${MY_PN}"
S="${WORKDIR}"
