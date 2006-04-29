# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostapd/hostapd-0.5.3.ebuild,v 1.1 2006/04/29 14:25:14 brix Exp $

inherit eutils toolchain-funcs

DESCRIPTION="IEEE 802.11 wireless LAN Host AP daemon"
HOMEPAGE="http://hostap.epitest.fi"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="ipv6 logwatch madwifi ssl"

RDEPEND="ssl? ( dev-libs/openssl )
		madwifi? ( || ( net-wireless/madwifi-ng net-wireless/madwifi-old ) )"
DEPEND="${RDEPEND}
		sys-apps/sed"

src_unpack() {
	local CONFIG=${S}/.config

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-os_get_random.patch

	sed -i -e "s:/etc/hostapd:/etc/hostapd/hostapd:g" \
		${S}/hostapd.conf

	# toolchain setup
	echo "CC = $(tc-getCC)" > ${CONFIG}

	# authentication methods
	echo "CONFIG_EAP=y"           >> ${CONFIG}
	echo "CONFIG_EAP_AKA=y"       >> ${CONFIG}
	echo "CONFIG_EAP_GTC=y"       >> ${CONFIG}
	echo "CONFIG_EAP_MD5=y"       >> ${CONFIG}
	echo "CONFIG_EAP_PAX=y"       >> ${CONFIG}
	echo "CONFIG_EAP_PSK=y"       >> ${CONFIG}
	echo "CONFIG_EAP_SIM=y"       >> ${CONFIG}
	echo "CONFIG_EAP_TLV=y"       >> ${CONFIG}
	echo "CONFIG_IAPP=y"          >> ${CONFIG}
	echo "CONFIG_PKCS12=y"        >> ${CONFIG}
	echo "CONFIG_RADIUS_SERVER=y" >> ${CONFIG}
	echo "CONFIG_RSN_PREAUTH=y"   >> ${CONFIG}
	echo "CONFIG_STAKEY=y"        >> ${CONFIG}

	if use ssl; then
		# SSL authentication methods
		echo "CONFIG_EAP_MSCHAPV2=y" >> ${CONFIG}
		echo "CONFIG_EAP_PEAP=y"     >> ${CONFIG}
		echo "CONFIG_EAP_TLS=y"      >> ${CONFIG}
		echo "CONFIG_EAP_TTLS=y"     >> ${CONFIG}
	fi

	if use ipv6; then
		echo "CONFIG_IPV6=y" >> ${CONFIG}
	fi

	# Linux specific drivers
	echo "CONFIG_DRIVER_HOSTAP=y"      >> ${CONFIG}
	echo "CONFIG_DRIVER_PRISM54=y"     >> ${CONFIG}
	echo "CONFIG_DRIVER_WIRED=y"       >> ${CONFIG}

	if use madwifi; then
		# Add include path for madwifi-driver headers
		echo "CFLAGS += -I${ROOT}/usr/include/madwifi" >> ${CONFIG}
		echo "CONFIG_DRIVER_MADWIFI=y"                 >> ${CONFIG}
	fi
}

src_compile() {
	emake || die "emake failed"

	if use ssl; then
		emake nt_password_hash || die "emake nt_password_hash failed"
		emake hlr_auc_gw || die "emake hlr_auc_gw failed"
	fi
}

src_install() {
	insinto /etc/hostapd
	doins hostapd.conf hostapd.accept hostapd.deny \
		hostapd.eap_user hostapd.radius_clients hostapd.sim_db hostapd.wpa_psk

	dosbin hostapd
	dobin hostapd_cli
	use ssl && dobin nt_password_hash
	use ssl && dobin hlr_auc_gw

	newinitd ${FILESDIR}/${P}-init.d hostapd
	newconfd ${FILESDIR}/${P}-conf.d hostapd

	doman hostapd.8 hostapd_cli.1

	dodoc ChangeLog developer.txt README

	docinto examples
	dodoc madwifi.conf wired.conf

	if use logwatch; then
		insinto /etc/log.d/conf/services/
		doins logwatch/hostapd.conf

		exeinto /etc/log.d/scripts/services/
		doexe logwatch/hostapd
	fi
}

pkg_postinst() {
	einfo
	einfo "In order to use ${PN} you need to set up your wireless card"
	einfo "for master mode in /etc/conf.d/net or /etc/conf.d/wireless"
	einfo "and then start /etc/init.d/hostapd."
	einfo
	einfo "Example configuration:"
	einfo
	einfo "config_wlan0=( \"192.168.1.1/24\" )"
	einfo "channel_wlan0=\"6\""
	einfo "essid_wlan0=\"test\""
	einfo "mode_wlan0=\"master\""
	einfo
	if use madwifi; then
		einfo "This package now compiles against the headers installed by"
		einfo "the madwifi driver. You should remerge ${PN} after"
		einfo "upgrading your madwifi driver."
		einfo
	fi
}
