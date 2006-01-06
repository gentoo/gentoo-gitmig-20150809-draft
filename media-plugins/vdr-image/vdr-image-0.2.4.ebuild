# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-image/vdr-image-0.2.4.ebuild,v 1.2 2006/01/06 01:36:26 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Image Plugin"
HOMEPAGE="http://deltab.de"
SRC_URI="http://download.berlios.de/vdr-image/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.3.20
	>=media-video/ffmpeg-0.4.8
	>=media-libs/netpbm-10.0"


VDRPLUGIN_MAKE_TARGET="all -j1"

src_unpack() {
vdr-plugin_src_unpack

	epatch ${FILESDIR}/${P}-gentoo.diff
}


src_install() {
vdr-plugin_src_install

	keepdir /etc/vdr/imagecmds
	insinto /etc/vdr/imagecmds
	newins examples/imagecmds.conf imagecmds.example.conf

	insinto /etc/vdr/plugins/image
	doins examples/imagesources.conf

	into /usr/share/vdr/image
	dobin scripts/imageplugin.sh
	newbin scripts/mount.sh mount-image.sh
}

pkg_postinst() {
vdr-plugin_pkg_postinst

	echo
	einfo "Also check /etc/vdr/plugins/image/imagesources.conf"
	echo
}
