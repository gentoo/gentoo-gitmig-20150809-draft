# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bemused/bemused-1.73.ebuild,v 1.1 2005/01/06 03:33:11 chriswhite Exp $

MY_P=${PN}linuxserver-${PV/1.73/1_73}

DESCRIPTION="Bemused is a system which allows you to control your music collection from your phone, using Bluetooth."
HOMEPAGE="http://bemused.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

S="${WORKDIR}/${PN}linuxserver${PV}"

DEPEND="media-sound/xmms
	net-wireless/bluez-libs"

src_compile() {
	make || die
}

src_install() {
	dobin bemusedlinuxserver
	insinto /etc
	doins bemused.conf

	dodoc ChangeLog authors copying readme todo

	einfo "Please note that due to the specific hardware nature"
	einfo "of this package, only upstream support can be"
	einfo "provided!"
}
