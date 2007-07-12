# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gspca/gspca-01.00.10.ebuild,v 1.6 2007/07/12 02:40:42 mr_bones_ Exp $

inherit linux-mod

S="${WORKDIR}/${P}/gspcav2"
DESCRIPTION="gspca driver for webcams."
HOMEPAGE="http://mxhaard.free.fr/spca5xx.html"
#http://mxhaard.free.fr/spca50x/Investigation/Gspca/gspcav1-01.00.10.tar.gz
SRC_URI="http://mxhaard.free.fr/spca50x/Investigation/Gspca/gspcav1-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RESTRICT=""
DEPEND=""
RDEPEND=""

MODULE_NAMES="gspca(usb/video:)"
BUILD_TARGETS="default"
CONFIG_CHECK="VIDEO_DEV"

pkg_setup() {
	elog "The package maintainer made a mistake.  You should consider using media-video/gspcav1"
	elog "instead.  This driver is still alpha.  --KingTaco"
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	convert_to_m ${S}/Makefile
	cd "${S}"
	epatch "${FILESDIR}"/gspca-20060813-defines.patch
}
