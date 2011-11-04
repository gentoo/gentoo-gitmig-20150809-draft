# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ps3mediaserver/ps3mediaserver-1.40.0.ebuild,v 1.1 2011/11/04 04:16:52 floppym Exp $

EAPI="4"

inherit eutils

DESCRIPTION="DLNA compliant UPNP server for streaming media to Playstation 3"
HOMEPAGE="http://code.google.com/p/ps3mediaserver"
SRC_URI="http://ps3mediaserver.googlecode.com/files/pms-generic-linux-unix-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+transcode tsmuxer"

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.6.0
	media-libs/libmediainfo
	media-libs/libzen
	tsmuxer? ( media-video/tsmuxer )
	transcode? ( media-video/mplayer[encode] )"

S=${WORKDIR}/pms-linux-${PV}

src_prepare() {
	cat > ${PN} <<-EOF
	#!/bin/sh
	echo "Setting up ~/.${PN} based on /usr/share/${PN}/"
	if [ ! -e ~/.${PN} ] ; then
		mkdir -p ~/.${PN}
		cp -pPR /usr/share/${PN}/* ~/.${PN}/
	fi
	cd ~/.${PN}
	PMS_HOME=\$PWD
	EOF
	cat PMS.sh >> ${PN}

	cat > ${PN}.desktop <<-EOF
	[Desktop Entry]
	Name=PS3 Media Server
	GenericName=Media Server
	Exec=${PN}
	Icon=${PN}
	Type=Application
	Categories=Network;
	EOF

	unzip -j pms.jar resources/images/icon-{32,256}.png || die
}

src_install() {
	dobin ${PN}
	insinto /usr/share/${PN}
	doins -r pms.jar *.conf documentation plugins renderers *.xml
	use tsmuxer && { dosym /opt/tsmuxer/bin/tsMuxeR /usr/share/${PN}/linux/tsMuxeR; }
	dodoc CHANGELOG README

	insinto /usr/share/icons/hicolor/32x32/apps
	newins icon-32.png ${PN}.png
	insinto /usr/share/icons/hicolor/256x256/apps
	newins icon-256.png ${PN}.png

	domenu ${PN}.desktop
}

pkg_postinst() {
	ewarn "Don't forget to disable transcoding engines for software"
	ewarn "that you don't have installed (such as having the VLC"
	ewarn "transcoding engine enabled when you only have mencoder)."
}
