# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-radio/vdr-radio-0.1.4.ebuild,v 1.3 2007/10/19 12:09:38 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: show background image for radio and decode RDS Text"
HOMEPAGE="http://vdrportal.de/board/thread.php?threadid=48687"
SRC_URI="http://www.egal-vdr.de/plugins/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.43"

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/radio
	doins "${S}"/mpegstill/rtext*
	dosym rtextOben-kleo2-live.mpg /usr/share/vdr/radio/radio.mpg
	dosym rtextOben-kleo2-replay.mpg /usr/share/vdr/radio/replay.mpg
}
