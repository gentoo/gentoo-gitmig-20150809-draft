# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetmonapplet/knetmonapplet-0.9.ebuild,v 1.8 2005/04/05 17:15:25 greg_g Exp $

inherit kde eutils

DESCRIPTION="Graphical network monitor for the KDE panel"
SRC_URI="http://ftp.kde.com/Computer_Devices/Networking/Monitoring/KnetmonApplet/${P}.tar.gz"
HOMEPAGE="http://perso.club-internet.fr/hftom/knetmonapplet/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

need-kde 3

src_unpack() {
	kde_src_unpack

	use arts || epatch "${FILESDIR}/${P}-noarts.patch"

	rm -f $S/knetmon/uiconfig.{h,cpp,moc}
}
