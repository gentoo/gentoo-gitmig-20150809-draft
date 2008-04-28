# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-radio/vdr-radio-0.2.0.ebuild,v 1.5 2008/04/28 10:59:19 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: show background image for radio and decode RDS Text"
HOMEPAGE="http://www.vdr-portal.de/board/thread.php?threadid=58795"
SRC_URI="http://www.egal-vdr.de/plugins/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.43"

VDR_RCADDON_FILE="${FILESDIR}/rc-addon.sh-0.2.0"

PATCHES=("${FILESDIR}/${P}-vdr-1.5.1.diff")

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/radio
	doins "${S}"/mpegstill/rtext*
	dosym rtextOben-kleo2-live.mpg /usr/share/vdr/radio/radio.mpg
	dosym rtextOben-kleo2-replay.mpg /usr/share/vdr/radio/replay.mpg

	keepdir "/var/cache/vdr-radio"
	chown -R vdr:vdr "${D}"/var/cache/vdr-radio
}
