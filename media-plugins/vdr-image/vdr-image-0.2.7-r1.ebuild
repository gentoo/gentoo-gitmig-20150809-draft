# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-image/vdr-image-0.2.7-r1.ebuild,v 1.2 2007/07/10 23:08:59 mr_bones_ Exp $

inherit vdr-plugin eutils

DESCRIPTION="Video Disk Recorder Image Plugin"
HOMEPAGE="http://vdr-image.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="exif"

DEPEND=">=media-video/vdr-1.3.38
	>=media-video/ffmpeg-0.4.8
	>=media-libs/netpbm-10.0
	exif? ( media-libs/libexif )
	dev-util/pkgconfig"

RDEPEND="${DEPEND}
	>=media-tv/gentoo-vdr-scripts-0.2.2"

PATCHES="${FILESDIR}/${P}-new-ffmpeg.diff"

VDRPLUGIN_MAKE_TARGET="all -j1"

src_unpack() {

	vdr-plugin_src_unpack

	epatch ${FILESDIR}/${P}-gentoo.diff

	use !exif && sed -i "s:#WITHOUT_LIBEXIF:WITHOUT_LIBEXIF:" Makefile
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
	elog "Also check /etc/vdr/plugins/image/imagesources.conf"
	echo
	elog "Multilanguage will automaticly supported, just take a look in"
	elog "/etc/vdr/imagecmds/* how it works"
	elog "By the moment only EN + DE"
	echo
}
