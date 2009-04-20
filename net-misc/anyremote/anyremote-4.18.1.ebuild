# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/anyremote/anyremote-4.18.1.ebuild,v 1.1 2009/04/20 11:40:17 hwoarang Exp $

EAPI="2"

DESCRIPTION="Anyremote provides wireless bluetooth, infrared or cable remote control service"
HOMEPAGE="http://anyremote.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bluetooth"

RDEPEND="bluetooth? ( || ( ( net-wireless/bluez-libs net-wireless/bluez-utils ) net-wireless/bluez ) )
	x11-libs/libXtst"

DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_enable bluetooth)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "install doc failed"
}
