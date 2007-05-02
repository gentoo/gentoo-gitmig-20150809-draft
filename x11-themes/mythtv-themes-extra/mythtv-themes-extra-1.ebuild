# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes-extra/mythtv-themes-extra-1.ebuild,v 1.1 2007/05/02 11:02:20 beandog Exp $

DESCRIPTION="User-contributed MythTV themes"
HOMEPAGE="http://homepage.ntlworld.com/justin.hornsby2/"
SRC_URI="mirror://gentoo/ProjectGrayhem-20061221.tar.bz2
	mirror://gentoo/ProjectGrayhem-wide-20070123.tar.bz2
	mirror://gentoo/blootube-20070311.tar.bz2
	mirror://gentoo/blootube-wide-20070311.tar.bz2
	mirror://gentoo/neon-wide-20070430.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="x11-themes/mythtv-themes"
RDEPEND="media-tv/mythtv"

src_install() {
	for x in ProjectGrayhem ProjectGrayhem-wide blootube blootube-wide \
		neon-wide; do
		dodir /usr/share/mythtv/themes/${x}
		cp -r ${WORKDIR}/${x}/* ${D}/usr/share/mythtv/themes/${x}
	done;
}
