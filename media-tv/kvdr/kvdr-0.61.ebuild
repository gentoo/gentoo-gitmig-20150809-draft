# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kvdr/kvdr-0.61.ebuild,v 1.6 2005/07/31 21:42:03 swegener Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Kvdr the KDE GUI for VDR (VideoDiskRecorder)"
SRC_URI="http://www.s.netic.de/gfiala/${P}.tgz"
HOMEPAGE="http://www.s.netic.de/gfiala/"

KEYWORDS="~x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-tv/xawtv-3.86
	>=media-tv/linuxtv-dvb-1.0.1
	>=media-video/vdr-1.2.0
	|| ( kde-base/kdebase-meta kde-base/kdebase )
	=x11-libs/qt-3*"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
