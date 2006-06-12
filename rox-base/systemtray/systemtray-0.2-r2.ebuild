# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/systemtray/systemtray-0.2-r2.ebuild,v 1.1 2006/06/12 14:20:35 dragonheart Exp $

# this patch makes system tray compatble with the new
# ROX-CLib verion 2.1.6 and higher. See bug #78309
inherit rox eutils

MY_PN="SystemTray"
PATCH_FN="01_all_systemtray-0.2-ROX-CLib-2.1.6.patch"
DESCRIPTION="SystemTray is a notification area applet for ROX-Filer"
HOMEPAGE="http://home.comcast.net/~andyhanton/software/"
SRC_URI="http://home.comcast.net/~andyhanton/software/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

ROX_LIB_VER=1.9.10
ROX_CLIB_VER=2.1.6

APPNAME="${MY_PN}"
S="${WORKDIR}"
SET_PERM=true

src_unpack() {
	unpack ${A}
	cd "${APPNAME}/src"
	epatch "${FILESDIR}/${PATCH_FN}"
}
