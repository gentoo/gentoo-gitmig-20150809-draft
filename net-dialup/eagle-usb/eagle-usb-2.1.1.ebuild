# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/eagle-usb/eagle-usb-2.1.1.ebuild,v 1.1 2005/02/25 21:18:35 mrness Exp $

inherit linux-mod

DESCRIPTION="GPL Driver for Eagle Chipset powered ADSL modem"
SRC_URI="http://download.gna.org/eagleusb/eagle-usb-2.1.0/${P}.tar.bz2"
HOMEPAGE="http://www.eagle-usb.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="net-dialup/ppp"

MODULE_NAMES="${PN}(net:${S}/driver)"
CONFIG_CHECK="!IPV6 USB"
BUILD_TARGETS=" "
BUILD_PARAMS="KERNELSRC=${KV_DIR}"

src_compile() {
	./autogen.sh || die "autogen.sh failed"
	CONFIG_FILES=Makefile.common econf --with-kernel-src=${KV_DIR} || die "econf failed"
	for i in pppoa utils/scripts utils/eagleconnect; do
		emake -C ${i} || die "emake ${i} failed"
	done

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	for i in driver/firmware driver/user pppoa utils/scripts utils/eagleconnect; do
		make DESTDIR=${D} -C ${i} install || die "make ${i} install failed"
	done

	doman doc/man/*
	dodoc README ChangeLog

	exeinto /etc/init.d ; newexe ${FILESDIR}/initd ${PN}
	insinto /etc/conf.d ; newins ${FILESDIR}/confd ${PN}
	insopts -m 600 ; insinto /etc/ppp/peers ; doins ${FILESDIR}/dsl.peer
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn "Please set METHOD in /etc/conf.d/${PN} to the needed value:"
	ewarn "dhcpip:"
	einfo "          Make sure you have dhcpcd emerged."
	ewarn "staticip:"
	einfo "          Set your static IP in /etc/conf.d/eagle-adsl"
	ewarn "dhcpip && staticip: You can use the following to set up the eagle conf-files:"
	echo 'sed -i -e "s/Encapsulation *= *[0-9]\+/Encapsulation=00000004/" /etc/eagle-usb/eagle-usb.conf'
	echo 'sed -i -e "s/VCI *= *[0-9]\+/VCI=00000024/" /etc/eagle-usb/eagle-usb.conf'
	ewarn "pppoa:"
	einfo "          Make sure you have kernel support for HDCL and PPP"
	einfo "          Edit /etc/ppp/peers/dsl.peer to insert your username as"
	einfo "          well as /etc/ppp/chap-secrets and /etc/ppp/pap-secrets"
	einfo
	einfo "          dsl.peer contains the \"usepeerdns\" option so, you"
	einfo "          should consider making a symlink named /etc/resolv.conf"
	einfo "          and pointing to /etc/ppp/resolv.conf:"
	echo "rm /etc/resolv.conf"
	echo "ln -s /etc/ppp/resolv.conf /etc/resolv.conf"
}
