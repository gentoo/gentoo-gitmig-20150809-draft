# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostapd/hostapd-0.3.3.ebuild,v 1.2 2005/01/18 11:21:36 brix Exp $

inherit toolchain-funcs

MADWIFI_VERSION="0.1_pre20041019"

DESCRIPTION="HostAP wireless daemon"
HOMEPAGE="http://hostap.epitest.fi"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz
		mirror://gentoo/madwifi-driver-${MADWIFI_VERSION}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"

src_unpack() {
	local CONFIG=${S}/.config

	unpack ${A}

	# toolchain setup
	echo "CC = $(tc-getCC)" > ${CONFIG}

	# authentication methods
	echo "CONFIG_EAP=y"           >> ${CONFIG}
	echo "CONFIG_EAP_MD5=y"       >> ${CONFIG}
	echo "CONFIG_EAP_GTC=y"       >> ${CONFIG}
	echo "CONFIG_IAPP=y"          >> ${CONFIG}
	echo "CONFIG_PKCS12=y"        >> ${CONFIG}
	echo "CONFIG_RADIUS_SERVER=y" >> ${CONFIG}
	echo "CONFIG_RSN_PREAUTH=y"   >> ${CONFIG}
	echo "CONFIG_EAP_SIM=y"       >> ${CONFIG}

	if use ssl; then
		# SSL authentication methods
		echo "CONFIG_EAP_MSCHAPV2=y" >> ${CONFIG}
		echo "CONFIG_EAP_PEAP=y"     >> ${CONFIG}
		echo "CONFIG_EAP_TLS=y"      >> ${CONFIG}
		echo "CONFIG_EAP_TTLS=y"     >> ${CONFIG}
	fi

	# Linux specific drivers
	echo "CONFIG_DRIVER_HOSTAP=y"  >> ${CONFIG}
	echo "CONFIG_DRIVER_WIRED=y"   >> ${CONFIG}
	echo "CONFIG_DRIVER_PRISM54=y" >> ${CONFIG}

	# Add include path for madwifi-driver headers
	echo "CFLAGS += -I${WORKDIR}"  >> ${CONFIG}
	echo "CONFIG_DRIVER_MADWIFI=y" >> ${CONFIG}
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	insinto /etc/hostapd
	doins hostapd.conf hostapd.accept hostapd.deny

	dosed 's:\(accept_mac_file=\)/etc/hostapd.accept:\1/etc/hostapd/hostapd.accept:g' \
		/etc/hostapd/hostapd.conf
	dosed 's:\(deny_mac_file=\)/etc/hostapd.deny:\1/etc/hostapd/hostapd.deny:g' \
		/etc/hostapd/hostapd.conf

	dosbin hostapd

	exeinto /etc/init.d
	newexe ${FILESDIR}/hostapd.init.d hostapd

	dodoc ChangeLog developer.txt README

	docinto examples
	dodoc madwifi.conf wired.conf
}
