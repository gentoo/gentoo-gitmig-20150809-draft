# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/spca5xx/spca5xx-20060402.ebuild,v 1.1 2006/04/14 15:54:11 kingtaco Exp $

inherit linux-mod

DESCRIPTION="spca5xx driver for webcams."
HOMEPAGE="http://mxhaard.free.fr/spca5xx.html"
SRC_URI="http://mxhaard.free.fr/spca50x/Download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RESTRICT=""
DEPEND=""
RDEPEND=""

MODULE_NAMES="spca5xx(usb/video:)"
BUILD_PARAMS="KERNELDIR=${KV_DIR}"
BUILD_TARGETS="default"

src_unpack() {
	unpack ${A}
	convert_to_m ${S}/Makefile
}

src_install() {
	dodoc CHANGELOG INSTALL README
	linux-mod_src_install
}
