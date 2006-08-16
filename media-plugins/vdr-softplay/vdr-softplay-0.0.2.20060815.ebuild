# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-softplay/vdr-softplay-0.0.2.20060815.ebuild,v 1.1 2006/08/16 07:32:35 zzam Exp $

inherit vdr-plugin versionator

MY_PV=$(get_version_component_range 4)
MY_P=${PN}-${MY_PV}

DESCRIPTION="VDR plugin: play media-files with vdr+vdr-softdevice as output device"
HOMEPAGE="http://softdevice.berlios.de/softplay/index.html"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.20
		>=media-plugins/vdr-softdevice-0.2.3.20060814-r1
		>=media-video/ffmpeg-0.4.9_pre1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${VDRPLUGIN}-${MY_PV}

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	# Inclusion of vdr-softdevice header-files from /usr/include/vdr-softdevice
	sed -i SoftPlayer.h -e 's#../softdevice/softdevice.h#vdr-softdevice/softdevice.h#'

	# ffmpeg-header-directory
	sed -i Makefile -e 's#^LIBFFMPEG=.*$#LIBFFMPEG=/usr/include/ffmpeg#'
}

