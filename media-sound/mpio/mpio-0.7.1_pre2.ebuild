# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpio/mpio-0.7.1_pre2.ebuild,v 1.2 2004/11/23 09:54:39 eradicator Exp $

IUSE=""

DESCRIPTION="Tool for the Digit@lway/Adtec MPIO MP3 players (DMG, DMK, DME, DMB, FD 100, FL100, FY100, FY200)"
HOMEPAGE="http://mpio.sourceforge.net/"
SRC_URI="mirror://sourceforge/mpio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="dev-libs/libusb
	sys-libs/readline"
RDEPEND=">=dev-libs/libusb-0.1.7
	>=sys-libs/readline-4.3
	sys-apps/hotplug"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS Changelog README TODO
}
