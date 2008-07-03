# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-image/vdr-image-0.2.7-r1.ebuild,v 1.7 2008/07/03 11:08:35 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: display of digital images, like jpeg, tiff, png, bmp"
HOMEPAGE="http://vdr-image.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="exif"

COMMON_DEPEND=">=media-video/vdr-1.3.38
	>=media-video/ffmpeg-0.4.8
	>=media-libs/netpbm-10.0
	exif? ( media-libs/libexif )"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	>=media-tv/gentoo-vdr-scripts-0.2.2"

PATCHES=("${FILESDIR}/${P}-new-ffmpeg.diff")

BUILD_PARAMS="-j1"

src_unpack() {

	vdr-plugin_src_unpack

	epatch "${FILESDIR}/${P}-gentoo.diff"

	use !exif && sed -i "s:#WITHOUT_LIBEXIF:WITHOUT_LIBEXIF:" Makefile
	if has_version "<=media-video/ffmpeg-0.4.9_p20061016"; then
		BUILD_PARAMS="${BUILD_PARAMS} WITHOUT_SWSCALER=1"
	fi

	if has_version ">=media-video/ffmpeg-0.4.9_p20080326" ; then
		epatch "${FILESDIR}/ffmpeg-0.4.9_p20080326-new_header.diff"
	fi
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
