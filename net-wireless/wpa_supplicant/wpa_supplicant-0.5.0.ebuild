# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/wpa_supplicant-0.5.0.ebuild,v 1.2 2005/12/30 22:36:10 brix Exp $

inherit eutils toolchain-funcs

MY_P=${PN}-${PV/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.1X/WPA supplicant for secure wireless transfers"
HOMEPAGE="http://hostap.epitest.fi/wpa_supplicant/"
SRC_URI="http://hostap.epitest.fi/releases/${MY_P}.tar.gz"
LICENSE="|| ( GPL-2 BSD )"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gsm qt readline ssl"

DEPEND="gsm? ( sys-apps/pcsc-lite )
		qt? ( || ( =x11-libs/qt-3* =x11-libs/qt-4* ) )
		readline? ( sys-libs/ncurses
					sys-libs/readline )
		ssl? ( dev-libs/openssl )"

src_unpack() {
	local CONFIG=${S}/.config

	unpack ${A}

	# toolchain setup
	echo "CC = $(tc-getCC)" > ${CONFIG}

	# basic setup
	echo "CONFIG_CTRL_IFACE=y"        >> ${CONFIG}
	echo "CONFIG_BACKEND=file"        >> ${CONFIG}

	# basic authentication methods
	echo "CONFIG_EAP_GTC=y"         >> ${CONFIG}
	echo "CONFIG_EAP_MD5=y"         >> ${CONFIG}
	echo "CONFIG_EAP_OTP=y"         >> ${CONFIG}
	echo "CONFIG_EAP_PSK=y"         >> ${CONFIG}
	echo "CONFIG_IEEE8021X_EAPOL=y" >> ${CONFIG}
	echo "CONFIG_PKCS12=y"          >> ${CONFIG}
	echo "CONFIG_STAKEY=y"          >> ${CONFIG}

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
}

src_compile() {
	emake || die "emake failed"

	if use qt; then
		if has_version '=x11-libs/qt-4*'; then
			qmake -o "${S}"/wpa_gui-qt4/Makefile "${S}"/wpa_gui-qt4/wpa_gui.pro
			cd "${S}"/wpa_gui-qt4
			emake || die "emake wpa_gui-qt4 failed"
		else
			[[ -d ${QTDIR}/etc/settings ]] && addwrite ${QTDIR}/etc/settings
			emake wpa_gui || die "emake wpa_gui failed"
		fi
	fi
}

src_install() {
	into /

	dosbin wpa_supplicant
	dobin wpa_cli wpa_passphrase

	newsbin ${FILESDIR}/${MY_P}-wpa_cli.action wpa_cli.action

	if use qt; then
		into /usr

		if has_version '=x11-libs/qt-4*'; then
			dobin wpa_gui-qt4/wpa_gui
		else
			dobin wpa_gui/wpa_gui
		fi
	fi

	dodoc ChangeLog COPYING eap_testing.txt README todo.txt
	dodoc doc/wpa_supplicant.fig

	insinto /etc
	newins wpa_supplicant.conf wpa_supplicant.conf.example

	doman doc/docbook/*.8
	doman doc/docbook/*.5
}

pkg_postinst() {
	einfo
	einfo "To use ${MY_P} you must create the configuration file"
	einfo "/etc/wpa_supplicant.conf"
	einfo
	einfo "An example configuration file has been installed as"
	einfo "/etc/wpa_supplicant.conf.example"
	einfo
	einfo "Please notice that madwifi support was removed in this version"
	einfo "of the ebuild. It will return once madwifi is stable again."
	einfo
}
