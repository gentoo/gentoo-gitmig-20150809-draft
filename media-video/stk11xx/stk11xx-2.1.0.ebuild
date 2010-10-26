# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/stk11xx/stk11xx-2.1.0.ebuild,v 1.2 2010/10/26 14:49:42 fauli Exp $

EAPI=2

inherit base linux-mod

DESCRIPTION="A driver for Syntek webcams often found in Asus notebooks"
HOMEPAGE="http://syntekdriver.sourceforge.net/"
SRC_URI="mirror://sourceforge/syntekdriver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MODULE_NAMES="${PN}(media/video:)"
CONFIG_CHECK="VIDEO_DEV VIDEO_V4L1_COMPAT"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_TARGETS="${PN}.ko"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S}"

	PATCHES=( "${FILESDIR}"/${PN}-v4l_compat_ioctl32.diff )
	MODULESD_STK11XX_DOCS=( README )
}
