# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ktraynetworker/ktraynetworker-0.8c.ebuild,v 1.2 2007/02/04 08:28:18 mr_bones_ Exp $

inherit kde

P_RES="ktraynetworker_resources_0.2"

DESCRIPTION="KDE tray icon Network activity monitor"
HOMEPAGE="http://www.xiaprojects.com/www/prodotti/ktraynetworker/main.php"
SRC_URI="http://www.xiaprojects.com/www/downloads/files/ktraynetworker/${P}.tar.bz2
	http://www.xiaprojects.com/www/downloads/files/ktraynetworker/${P_RES}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

need-kde 3.2

src_unpack()
{
	kde_src_unpack
	mkdir themes
	tar -x -j -f ${WORKDIR}/${P_RES}/themes.tar.bz2 -C ./themes || die "Themes tarball could not be unpacked."
}

src_install()
{
	kde_src_install
	dodir /usr/share/apps/ktraynetworker/themes
	cp -r themes/* ${D}/usr/share/apps/ktraynetworker/themes
}
