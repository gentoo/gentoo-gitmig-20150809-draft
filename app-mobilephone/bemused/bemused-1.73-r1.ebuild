# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/bemused/bemused-1.73-r1.ebuild,v 1.3 2007/11/22 10:16:00 mrness Exp $

inherit eutils

DESCRIPTION="Bemused is a system which allows you to control your music collection from your phone, using Bluetooth."
HOMEPAGE="http://bemused.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}linuxserver-${PV/./_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${PN}linuxserver${PV}"

RDEPEND="=media-sound/audacious-1.3*
	net-wireless/bluez-libs"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-audacious.patch"
}

src_install() {
	dobin bemusedlinuxserver
	insinto /etc
	doins bemused.conf

	dodoc ChangeLog authors copying readme todo

	elog "Please note that due to the specific hardware nature"
	elog "of this package, only upstream support can be"
	elog "provided!"
}
