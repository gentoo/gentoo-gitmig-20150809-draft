# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/packetcommand/packetcommand-0.5.ebuild,v 1.3 2007/07/12 02:40:42 mr_bones_ Exp $

inherit linux-mod eutils

DESCRIPTION="A driver for the em84xx dvd disc access."
HOMEPAGE="http://www.htpc-forum.de"
SRC_URI="http://www.htpc-forum.de/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=""
DEPEND="media-video/em84xx-modules"

CONFIG_CHECK="IDE"

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="packetcommand(video:)"
	BUILD_TARGETS="all"
	BUILD_PARAMS="KDIR=\"${KV_DIR}\" V=1"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${PV}/kernel-2.6.19.diff
}
