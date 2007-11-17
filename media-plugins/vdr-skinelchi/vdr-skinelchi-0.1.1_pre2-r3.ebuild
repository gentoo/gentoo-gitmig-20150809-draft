# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinelchi/vdr-skinelchi-0.1.1_pre2-r3.ebuild,v 1.5 2007/11/17 09:48:19 hd_brummy Exp $

inherit vdr-plugin

MY_P=${P/_pre/pre}

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.vdrportal.de/board/thread.php?threadid=41915&sid="
SRC_URI="mirror://gentoo/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="imagemagick"

DEPEND=">=media-video/vdr-1.3.22
		imagemagick? ( media-gfx/imagemagick )"

RDEPEND="x11-themes/vdr-channel-logos"

S=${WORKDIR}/${MY_P#vdr-}

VDR_RCADDON_FILE="${FILESDIR}/rc-addon-${PV}-r1.sh"

PATCHES="${FILESDIR}/${P}-PatchCollection-FireFly.diff
	${FILESDIR}/${P}-vdr-1.5.5-getfont.diff"
#	${FILESDIR}/test.diff"

src_unpack() {
	vdr-plugin_src_unpack

	if use imagemagick; then
		elog "Enabling imagemagick-support."
		sed -i ${S}/Makefile -e 's/^#HAVE_IMAGEMAGICK/HAVE_IMAGEMAGICK/'
	fi

	sed -i DisplayMenu.h -e "s:uint64:uint64_t:"

	#fix compile warnings , gcc-1.4.x
	sed -i symbols/*.xpm -e "s:static char:static const char:"
}
