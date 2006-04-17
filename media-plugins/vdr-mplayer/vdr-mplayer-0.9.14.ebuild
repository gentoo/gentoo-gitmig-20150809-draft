# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mplayer/vdr-mplayer-0.9.14.ebuild,v 1.2 2006/04/17 17:13:59 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="Video Disk Recorder Mplayer Plugin"
HOMEPAGE="http://www.muempf.de/"
SRC_URI="http://www.muempf.de/down/vdr-mp3-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"

RDEPEND=">=media-video/mplayer-0.90_rc4
		>=media-video/mplayer-sh-0.8.6-r1"

S=${WORKDIR}/mp3-${PV}

src_unpack() {

	vdr-plugin_src_unpack

	epatch ${FILESDIR}/${P}-gentoo.diff
}


src_install() {

	vdr-plugin_src_install

	insinto /etc/vdr/plugins/mplayer
	doins   ${FILESDIR}/mplayersources.conf

	into /usr/share/vdr/mplayer
	newbin examples/mount.sh.example mount-mplayer.sh

	dodoc HISTORY MANUAL README examples/{image_convert,network}.sh.example
}

pkg_postinst() {

	vdr-plugin_pkg_postinst

	echo
	einfo "Edit all config's /etc/vdr/plugins/mplayer"
	echo

	if ! has_version "media-plugins/vdr-mp3ng" ; then
		einfo "Splitted ebuild!, no support for Audio files"
		einfo "To play mp3, ogg and wav files,"
		einfo "emerge media-plugins/vdr-mp3ng -pv"
		echo
	fi
}
