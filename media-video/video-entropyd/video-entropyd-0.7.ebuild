# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/video-entropyd/video-entropyd-0.7.ebuild,v 1.6 2006/02/16 18:31:04 halcy0n Exp $

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Video-entropyd generates entropy-data for the /dev/random device."
HOMEPAGE="http://www.vanheusden.com/ved/"
SRC_URI="http://www.vanheusden.com/ved/${MY_P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
RDEPEND="virtual/libc
		media-libs/netpbm"
DEPEND="${RDEPEND}
		sys-kernel/linux-headers" # v4l headers from kernel
S="${WORKDIR}/${MY_P}"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	newsbin video_entropyd video-entropyd
}

pkg_postinst() {
	einfo "As video-entropyd does not provide a daemon mode, you"
	einfo "should configure a cron job to regularly run:"
	einfo "/usr/sbin/video-entropyd VIDEODEVICE"
}
