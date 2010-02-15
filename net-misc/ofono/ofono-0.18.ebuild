# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ofono/ofono-0.18.ebuild,v 1.1 2010/02/15 14:04:45 dagger Exp $

EAPI="2"

DESCRIPTION="Open Source mobile telephony (GSM/UMTS) daemon."
HOMEPAGE="http://ofono.org/"
SRC_URI="mirror://kernel/linux/network/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="bluetooth threads +udev"

RDEPEND=">=sys-apps/dbus-1.3
	bluetooth? ( >=net-wireless/bluez-4.61 )
	>=dev-libs/glib-2.16
	udev? ( >=sys-fs/udev-143 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable threads) \
		$(use_enable udev) \
		--localstatedir="${ROOT}"/var
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die
}
