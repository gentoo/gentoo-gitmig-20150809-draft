# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kvdr/kvdr-0.63.ebuild,v 1.1 2005/08/21 20:47:59 greg_g Exp $

inherit kde

DESCRIPTION="A KDE GUI for VDR (Video Disk Recorder)."
HOMEPAGE="http://www.s.netic.de/gfiala/"
SRC_URI="http://www.s.netic.de/gfiala/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-tv/xawtv-3.86
	>=media-tv/linuxtv-dvb-1.0.1
	>=media-video/vdr-1.2.0"

need-kde 3

S=${WORKDIR}/${PN}

src_unpack() {
	kde_src_unpack

	sed -i -e 's,test "\$ac_x_includes" = no,test "\$ac_x_includes" = NO,' \
	       -e 's,test "\$ac_x_libraries" = no,test "\$ac_x_libraries" = NO,' configure || die
}
