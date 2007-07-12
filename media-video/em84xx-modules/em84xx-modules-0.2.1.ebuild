# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em84xx-modules/em84xx-modules-0.2.1.ebuild,v 1.2 2007/07/12 02:40:43 mr_bones_ Exp $

inherit linux-mod eutils

SF_PROJECT=${PN%-modules}

MY_PN=realmagic
MY_P=${MY_PN}-${PV}

DESCRIPTION="kernel modules for em84xx based mpeg-decoder cards"
HOMEPAGE="http://sourceforge.net/projects/em84xx/"
SRC_URI="mirror://sourceforge/${SF_PROJECT}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/linux-sources"

S=${WORKDIR}/${MY_PN}

pkg_setup() {
	linux-mod_pkg_setup

	MODULE_NAMES="realmagic84xx(video:${S})"
	BUILD_PARAMS="KDIR=${KV_DIR}"
	BUILD_TARGETS="all"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-kernel-2.6.19.diff
}

src_install() {
	linux-mod_src_install

	dodoc README TODO HISTORY
}
