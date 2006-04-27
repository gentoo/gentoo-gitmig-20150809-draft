# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-radio/vdr-radio-0.1.2.ebuild,v 1.1 2006/04/27 21:21:29 hd_brummy Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: show background image for radio and decode RDS Text"
HOMEPAGE="http://vdrportal.de/board/thread.php?threadid=37042"
SRC_URI="http://www.egal-vdr.de/plugins/vdr-radio-0.1.2.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.43"

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/radio
	doins ${S}/mpegstill/rtext*
	dosym rtextOben-kleo2-live.mpg /usr/share/vdr/radio/radio.mpg
	dosym rtextOben-kleo2-replay.mpg /usr/share/vdr/radio/replay.mpg
}
