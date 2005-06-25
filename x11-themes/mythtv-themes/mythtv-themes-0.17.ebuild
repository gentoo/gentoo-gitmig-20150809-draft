# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-0.17.ebuild,v 1.3 2005/06/25 14:05:04 swegener Exp $

DESCRIPTION="A collection of themes for the MythTV project."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/myththemes/purgalaxy/PurpleGalaxy.tar.gz
	 http://www.mythtv.org/myththemes/visor/visor.tar.gz
	 http://www.mythtv.org/myththemes/sleek/sleek-0.35.tar.bz2
	 http://www.mythtv.org/myththemes/abstract/abstract.tar.bz2
	 http://files.radixpub.com/MythTVMediaCenter.tar.bz2
	 http://files.radixpub.com/MythTVMediaCenterOSD.tar.bz2
	 http://www.aldorf.no/mythtv/isthmus.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-tv/mythtv-${PV}"

src_install() {
	find "${WORKDIR}" -type f -print0 | xargs -0 chmod 644
	find "${WORKDIR}" -type d -print0 | xargs -0 chmod 755

	dodir /usr/share/mythtv
	cp -r "${WORKDIR}" "${D}/usr/share/mythtv/themes"
}
