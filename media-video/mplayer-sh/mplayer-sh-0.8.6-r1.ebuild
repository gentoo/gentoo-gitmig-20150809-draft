# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer-sh/mplayer-sh-0.8.6-r1.ebuild,v 1.1 2006/01/08 21:35:14 hd_brummy Exp $

DESCRIPTION="Video Disk Recorder Mplayer API Script"
HOMEPAGE="http://batleth.sapienti-sat.org/"
SRC_URI="http://batleth.sapienti-sat.org/projects/VDR/mplayer.sh-${PV}.tar.gz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="as-is"
IUSE=""

RDEPEND=">=media-video/vdr-1.2.0
	>=media-video/mplayer-0.90_rc4
	>=media-plugins/vdr-mplayer-0.9.13-r1"

S=${WORKDIR}

src_unpack() {

	unpack ${A}
	cd ${S}

	sed -i "s:^declare CFGFIL.*$:declare CFGFIL=\"\/etc\/vdr\/plugins\/mplayer\/mplayer.sh.conf\":"  mplayer.sh
	sed -i mplayer.sh.conf -e "s:^LIRCRC.*$:LIRCRC=\/etc\/lircd.conf:" \
		-e "s:^MPLAYER=.*$:MPLAYER=\/usr\/bin\/mplayer:"
}


src_install() {

	insinto /etc/vdr/plugins/mplayer
	doins mplayer.sh.conf

	into /usr/share/vdr/mplayer
	dobin mplayer.sh

	dodir /etc/vdr/plugins/DVD-VCD
	touch	${D}/etc/vdr/plugins/DVD-VCD/{DVD,VCD}
	fowners vdr:video /etc/vdr/plugins/DVD-VCD/{DVD,VCD}
}
