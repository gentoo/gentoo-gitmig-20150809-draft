# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Alexander Papaspyrou <alexander.papaspyrou@udo.edu
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetmonapplet/knetmonapplet-0.9.ebuild,v 1.5 2004/07/15 02:55:57 agriffis Exp $

inherit kde
need-kde 3

DESCRIPTION="Graphical network monitor for the KDE panel"
SRC_URI="http://ftp.kde.com/Computer_Devices/Networking/Monitoring/KnetmonApplet/${P}.tar.gz"
HOMEPAGE="http://perso.club-internet.fr/hftom/knetmonapplet/"

LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	kde_src_unpack

	rm -f $S/knetmon/uiconfig.{h,cpp,moc}
}
