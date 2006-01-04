# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/spca5xx/spca5xx-20060101.ebuild,v 1.1 2006/01/04 19:55:52 kingtaco Exp $

inherit linux-mod

DESCRIPTION="spca5xx driver for webcams."
HOMEPAGE="http://mxhaard.free.fr/spca5xx.html"
SRC_URI="http://mxhaard.free.fr/spca50x/Download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	ewarn "Warning:  The module name has been changed from spca50x to spca5xx."
}
