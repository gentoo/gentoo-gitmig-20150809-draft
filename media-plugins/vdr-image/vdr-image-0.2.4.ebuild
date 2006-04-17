# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-image/vdr-image-0.2.4.ebuild,v 1.5 2006/04/17 16:45:37 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="Video Disk Recorder Image Plugin"
HOMEPAGE="http://deltab.de"
SRC_URI="http://download.berlios.de/vdr-image/${P}.tar.gz"

KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.3.20
	>=media-video/ffmpeg-0.4.8
	>=media-libs/netpbm-10.0"

RDEPEND=">=media-tv/gentoo-vdr-scripts-0.2.2"


VDRPLUGIN_MAKE_TARGET="all -j1"

src_unpack() {

	vdr-plugin_src_unpack

	epatch ${FILESDIR}/${P}-gentoo.diff
}


src_install() {

	vdr-plugin_src_install

	insinto /etc/vdr/imagecmds
	newins examples/imagecmds.conf imagecmds.example.conf
	newins examples/imagecmds.conf.DE imagecmds.example.conf.de

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
	einfo "Multilanguage will automaticly supported, just take a look in"
	einfo "/etc/vdr/imagecmds/* how it works"
	einfo "By the moment only EN + DE"
	echo
}
