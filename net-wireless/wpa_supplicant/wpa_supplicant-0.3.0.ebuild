# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/wpa_supplicant-0.3.0.ebuild,v 1.1 2004/12/11 14:39:12 brix Exp $

inherit toolchain-funcs

MADWIFI_VERSION="0.1_pre20041019"

DESCRIPTION="IEEE 802.1X/WPA supplicant for secure wireless transfers"
HOMEPAGE="http://hostap.epitest.fi/wpa_supplicant/"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz
		mirror://gentoo/madwifi-driver-${MADWIFI_VERSION}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
#IUSE="gsm ssl"
IUSE="ssl"

RDEPEND="ssl? ( dev-libs/openssl )"
#		gsm? ( sys-apps/pcsc-lite )

src_unpack() {
	local CONFIG=${S}/.config

	unpack ${A}

	# toolchain setup
	echo "CC = $(tc-getCC)" > ${CONFIG}

	# basic authentication methods
	echo "CONFIG_EAP_GTC=y"         >> ${CONFIG}
	echo "CONFIG_EAP_MD5=y"         >> ${CONFIG}
	echo "CONFIG_EAP_OTP=y"         >> ${CONFIG}
	echo "CONFIG_EAP_PSK=y"         >> ${CONFIG}
	echo "CONFIG_IEEE8021X_EAPOL=y" >> ${CONFIG}

	if use ssl; then
		# SSL authentication methods
		echo "CONFIG_EAP_LEAP=y"     >> ${CONFIG}
		echo "CONFIG_EAP_MSCHAPV2=y" >> ${CONFIG}
		echo "CONFIG_EAP_PEAP=y"     >> ${CONFIG}
		echo "CONFIG_EAP_TLS=y"      >> ${CONFIG}
		echo "CONFIG_EAP_TTLS=y"     >> ${CONFIG}
	fi

#	Note: PCSC support is disabled in 0.3.0 due to a bug in the code.
#	This has been fixed in upstream CVS (brix)
#
#	if use gsm; then
#		# Smart card authentication
#		echo "CONFIG_EAP_SIM=y" >> ${CONFIG}
#		echo "CONFIG_EAP_AKA=y" >> ${CONFIG}
#		echo "CONFIG_PCSC=y"    >> ${CONFIG}
#		echo "CFLAGS += -I/usr/include/PCSC" >> ${CONFIG}
#	fi

	# Linux specific drivers
	echo "CONFIG_WIRELESS_EXTENSION=y" >> ${CONFIG}
	echo "CONFIG_DRIVER_ATMEL=y"       >> ${CONFIG}
	echo "CONFIG_DRIVER_HOSTAP=y"      >> ${CONFIG}
	echo "CONFIG_DRIVER_IPW2100=y"     >> ${CONFIG}
	echo "CONFIG_DRIVER_NDISWRAPPER=y" >> ${CONFIG}
	echo "CONFIG_DRIVER_PRISM54=y"     >> ${CONFIG}
	echo "CONFIG_DRIVER_WEXT=y"        >> ${CONFIG}

	# Add include path for madwifi-driver headers
	echo "CFLAGS += -I${WORKDIR}"  >> ${CONFIG}
	echo "CONFIG_DRIVER_MADWIFI=y" >> ${CONFIG}
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin wpa_supplicant
	dobin wpa_cli wpa_passphrase

	dodoc ChangeLog COPYING developer.txt eap_testing.txt README todo.txt
	dodoc doc/wpa_supplicant.fig

	insinto /etc
	newins wpa_supplicant.conf wpa_supplicant.conf.example

	exeinto /etc/init.d
	newexe ${FILESDIR}/${P}-init.d wpa_supplicant || die

	insinto /etc/conf.d
	newins ${FILESDIR}/${P}-conf.d wpa_supplicant || die
}

pkg_postinst() {
	einfo
	einfo "To use ${P} you must create the configuration file"
	einfo "/etc/wpa_supplicant.conf"
	einfo
	einfo "An example configuration file has been installed as"
	einfo "/etc/wpa_supplicant.conf.example"
	einfo
}
