# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes-extra/mythtv-themes-extra-0.20.1.ebuild,v 1.1 2007/08/12 15:44:20 beandog Exp $

DESCRIPTION="User-contributed MythTV themes"
HOMEPAGE="http://www.mythtv.org/wiki/index.php/Themes"
SRC_URI="mirror://gentoo/ProjectGrayhem-20061221.tar.bz2
	mirror://gentoo/ProjectGrayhem-wide-20070123.tar.bz2
	mirror://gentoo/blootube-20070311.tar.bz2
	mirror://gentoo/blootube-wide-20070311.tar.bz2
	mirror://gentoo/neon-wide-20070430.tar.bz2
	http://www.stealthboy.com/BlueSky.20031024.tar.gz
	http://www.stealthboy.com/PurpleGalaxy.20031214.tar.gz
	http://files.radixpub.com/MythTVMediaCenter.0.20.tar.bz2
	http://files.radixpub.com/MythTVMediaCenter.OSD.0.20.tar.bz2
	http://home.comcast.net/~zdzisekg/download/MePo-wide-0.3.5.tar.gz"
LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="x11-themes/mythtv-themes"
RDEPEND="media-tv/mythtv"

src_install() {
	for x in ProjectGrayhem ProjectGrayhem-wide blootube blootube-wide \
		neon-wide BlueSky PurpleGalaxy MythTVMediaCenter \
		MythTVMediaCenterOSD MePo-wide; do
		dodir /usr/share/mythtv/themes/${x}
		cp -r ${WORKDIR}/${x}/* ${D}/usr/share/mythtv/themes/${x}
	done;
}
