# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ofono/ofono-0.36.ebuild,v 1.1 2010/12/17 14:49:08 dagger Exp $

EAPI="2"

inherit multilib

DESCRIPTION="Open Source mobile telephony (GSM/UMTS) daemon."
HOMEPAGE="http://ofono.org/"
SRC_URI="mirror://kernel/linux/network/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="+atmodem bluetooth +caps examples +isimodem threads +udev"

RDEPEND=">=sys-apps/dbus-1.2.24
	bluetooth? ( >=net-wireless/bluez-4.61 )
	caps? ( sys-libs/libcap-ng )
	>=dev-libs/glib-2.16
	udev? ( >=sys-fs/udev-143 )
	examples? ( dev-python/dbus-python )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable caps capng) \
		$(use_enable threads) \
		$(use_enable udev) \
		$(use_enable isimodem) \
		$(use_enable atmodem) \
		--enable-test \
		--localstatedir=/var
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if ! use examples ; then
		rm -rf ${D}/usr/"$(get_libdir)"/ofono/test
	fi

	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die
	dodoc ChangeLog AUTHORS doc/*.txt
}
