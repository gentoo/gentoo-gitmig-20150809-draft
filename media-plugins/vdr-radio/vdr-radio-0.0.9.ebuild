# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-radio/vdr-radio-0.0.9.ebuild,v 1.4 2006/04/27 13:17:45 zzam Exp $

inherit vdr-plugin

DESCRIPTION="DVB Radio with RDS Text plugin for VDR >= 1.3.21"
HOMEPAGE="http://vdrportal.de/board/thread.php?threadid=37042"
SRC_URI="mirror://gentoo/${P}.tgz
		mirror://gentoo/radioimages_rtext-kleo2.tgz
		mirror://vdrfiles/${PN}/${P#vdr-}.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.21"

PATCHES="${DISTDIR}/${P#vdr-}.patch"

src_install() {

	vdr-plugin_src_install

	insinto /usr/share/vdr/radio
	newins ${WORKDIR}/rtextOben-kleo2.mpg radio.mpg
}
