# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/wpa_supplicant-0.4.4.ebuild,v 1.1 2005/08/22 12:53:24 brix Exp $

inherit eutils toolchain-funcs

MY_P=${PN}-${PV/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.1X/WPA supplicant for secure wireless transfers"
HOMEPAGE="http://hostap.epitest.fi/wpa_supplicant/"
SRC_URI="http://hostap.epitest.fi/releases/${MY_P}.tar.gz"
LICENSE="|| ( GPL-2 BSD )"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug gsm madwifi qt readline ssl"

DEPEND="gsm? ( sys-apps/pcsc-lite )
		qt? ( =x11-libs/qt-3* )
		readline? ( sys-libs/ncurses
					sys-libs/readline )
		ssl? ( dev-libs/openssl )
		madwifi? ( >=net-wireless/madwifi-driver-0.1_pre20050420-r1 )
		>=sys-apps/baselayout-1.11.13"

src_unpack() {
	local CONFIG=${S}/.config

	unpack ${A}

	# toolchain setup
	echo "CC = $(tc-getCC)" > ${CONFIG}

	# basic setup
	echo "CONFIG_CTRL_IFACE=y"        >> ${CONFIG}

	# basic authentication methods
	echo "CONFIG_EAP_GTC=y"         >> ${CONFIG}
	echo "CONFIG_EAP_MD5=y"         >> ${CONFIG}
	echo "CONFIG_EAP_OTP=y"         >> ${CONFIG}
	echo "CONFIG_EAP_PSK=y"         >> ${CONFIG}
	echo "CONFIG_IEEE8021X_EAPOL=y" >> ${CONFIG}
	echo "CONFIG_PKCS12=y"          >> ${CONFIG}

	if ! use debug; then
		echo "CONFIG_NO_STDOUT_DEBUG=y" >> ${CONFIG}
	fi

	if use gsm; then
		# smart card authentication
		echo "CONFIG_EAP_SIM=y" >> ${CONFIG}
		echo "CONFIG_EAP_AKA=y" >> ${CONFIG}
		echo "CONFIG_PCSC=y"    >> ${CONFIG}
	fi

	if use readline; then
		# readline/history support for wpa_cli
		echo "CONFIG_READLINE=y" >> ${CONFIG}
	fi

	if use ssl; then
		# SSL authentication methods
		echo "CONFIG_EAP_LEAP=y"     >> ${CONFIG}
		echo "CONFIG_EAP_MSCHAPV2=y" >> ${CONFIG}
		echo "CONFIG_EAP_PEAP=y"     >> ${CONFIG}
		echo "CONFIG_EAP_TLS=y"      >> ${CONFIG}
		echo "CONFIG_EAP_TTLS=y"     >> ${CONFIG}
		echo "CONFIG_SMARTCARD=y"    >> ${CONFIG}
	fi

	# Linux specific drivers
	echo "CONFIG_WIRELESS_EXTENSION=y" >> ${CONFIG}
	echo "CONFIG_DRIVER_ATMEL=y"       >> ${CONFIG}
	echo "CONFIG_DRIVER_HOSTAP=y"      >> ${CONFIG}
	echo "CONFIG_DRIVER_IPW=y"         >> ${CONFIG}
	echo "CONFIG_DRIVER_NDISWRAPPER=y" >> ${CONFIG}
	echo "CONFIG_DRIVER_PRISM54=y"     >> ${CONFIG}
	echo "CONFIG_DRIVER_WEXT=y"        >> ${CONFIG}
	echo "CONFIG_DRIVER_WIRED=y"       >> ${CONFIG}

	if use madwifi; then
		# Add include path for madwifi-driver headers
		echo "CFLAGS += -I/usr/include/madwifi" >> ${CONFIG}
		echo "CONFIG_DRIVER_MADWIFI=y"           >> ${CONFIG}
	fi
}

src_compile() {
	emake || die "emake failed"

	if use qt; then
		[[ -d ${QTDIR}/etc/settings ]] && addwrite ${QTDIR}/etc/settings
		emake wpa_gui || die "emake wpa_gui failed"
	fi
}

src_install() {
	into /

	dosbin wpa_supplicant
	dobin wpa_cli wpa_passphrase

	newsbin ${FILESDIR}/${MY_P}-wpa_cli.action wpa_cli.action

	if use qt; then
		into /usr
		dobin wpa_gui/wpa_gui
	fi

	dodoc ChangeLog COPYING eap_testing.txt README todo.txt
	dodoc doc/wpa_supplicant.fig

	insinto /etc
	newins wpa_supplicant.conf wpa_supplicant.conf.example
}

pkg_postinst() {
	einfo
	einfo "To use ${MY_P} you must create the configuration file"
	einfo "/etc/wpa_supplicant.conf"
	einfo
	einfo "An example configuration file has been installed as"
	einfo "/etc/wpa_supplicant.conf.example"
	einfo
	einfo "Please note that the wpa_supplicant init script has been"
	einfo "removed in favor of sys-apps/baselayout-1.11.x"
	einfo
	if use madwifi; then
		einfo "This package now compiles against the headers installed by"
		einfo "net-wireless/madwifi-driver. You should remerge ${PN} after"
		einfo "upgrading net-wireless/madwifi-driver."
		einfo
	fi
}
