# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ps3mediaserver/ps3mediaserver-1.20.412.ebuild,v 1.1 2011/01/06 04:46:23 vapier Exp $

EAPI="2"

DESCRIPTION="DLNA compliant UPNP server for streaming media to Playstation 3"
HOMEPAGE="http://code.google.com/p/ps3mediaserver"
SRC_URI="http://ps3mediaserver.googlecode.com/files/pms-generic-linux-unix-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+transcode tsmuxer"

DEPEND=""
RDEPEND=">=virtual/jre-1.6.0
	tsmuxer? ( media-video/tsmuxer )
	transcode? ( media-video/mplayer[encode] )"

S=${WORKDIR}/pms-linux-${PV}

src_prepare() {
	rm linux/tsMuxeR* || die
	cat <<-EOF > pms
	#!/bin/sh
	echo "Setting up ~/.ps3mediaserver based on /usr/share/pms/"
	if [ ! -e ~/.ps3mediaserver ] ; then
		mkdir -p ~/.ps3mediaserver
		cp -pPR /usr/share/pms/* ~/.ps3mediaserver/
	fi
	cd ~/.ps3mediaserver
	PMS_HOME=\$PWD
	EOF
	cat PMS.sh >> pms
}

src_install() {
	dobin pms || die
	insinto /usr/share/pms
	doins -r pms.jar *.conf linux plugins renderers || die
	use tsmuxer && { dosym /opt/bin/tsMuxeR /usr/share/pms/linux/ || die ; }
	dodoc CHANGELOG FAQ README
}

pkg_postinst() {
	ewarn "Don't forget to disable transcoding engines for software"
	ewarn "that you don't have installed (such as having the VLC"
	ewarn "transcoding engine enabled when you only have mencoder)."
}
