# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kwlaninfo/kwlaninfo-0.9.4.ebuild,v 1.5 2007/07/02 15:18:41 peper Exp $

inherit kde eutils

IUSE=""

DESCRIPTION="KDE Applet to display information about wlan connections"
HOMEPAGE="http://www.ph-home.de/opensource/kde3/kwlaninfo/"
SRC_URI="http://www.ph-home.de/opensource/kde3/${PN}/${P}.tgz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="net-wireless/wireless-tools"

need-kde 3.0

src_unpack() {
	kde_src_unpack

	cd ${S}
	epatch ${FILESDIR}/${PN}-desktop.patch
}
