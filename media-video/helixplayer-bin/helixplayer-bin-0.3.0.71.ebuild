# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/helixplayer-bin/helixplayer-bin-0.3.0.71.ebuild,v 1.1 2004/04/26 19:23:05 kanaka Exp $

inherit nsplugins

#A="hxplay-linux-2.2-libc6-gcc32-i586.tar.gz"
A="hxplay-0.3.0.71-linux-2.2-libc6-gcc32-i586.tar.bz2"
DESCRIPTION="Helix Player"

DOWNLOAD_URI="http://forms.helixcommunity.org/helixdnaclient/index.html?filename=20040423/player_all-helix-player-20040423-linux-2.2-libc6-gcc32-i586/hxplay-0.3.0.71-linux-2.2-libc6-gcc32-i586.tar.bz2"
HOMEPAGE="https://player.helixcommunity.org"

LICENSE="realsdk"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/x11
		>=x11-libs/gtk+-2.2.0
		media-libs/libvorbis
		media-libs/libogg
		media-libs/faad2"
S=${WORKDIR}/hxplay-linux-2.2-libc6-gcc32-i586

RESTRICT="nostrip fetch"

src_unpack() {
	if [ ! -f ${DISTDIR}/${A} ] ; then
		eerror "Please download ${A} from ${DOWNLOAD_URI} to ${DISTDIR}"
		die "Some source files were not found"
	fi
}

src_install () {
	mkdir -p ${D}/opt/HelixPlayer
	cd ${D}/opt/HelixPlayer

	# Install the player
	tar xvjf ${DISTDIR}/${A}
	mkdir -p ${D}/usr/bin
	dosym /opt/HelixPlayer/hxplay /usr/bin/hxplay

	# Install the Mozilla plugin
	inst_plugin /opt/HelixPlayer/mozilla/nphelix.so
	inst_plugin /opt/HelixPlayer/mozilla/nphelix.xpt
}
