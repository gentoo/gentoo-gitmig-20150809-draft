# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa-supplicant/wpa-supplicant-0.2.5.ebuild,v 1.2 2004/10/18 12:27:04 dholm Exp $

inherit eutils

MADWIFI_VERSION="0.1_pre20040906"

MY_P="${P/wpa-/wpa_}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="WPA Supplicant for secure wireless transfers"
HOMEPAGE="http://hostap.epitest.fi/wpa_supplicant/"
SRC_URI="http://hostap.epitest.fi/releases/${MY_P}.tar.gz
		mirror://gentoo/madwifi-driver-${MADWIFI_VERSION}.tar.bz2
		mirror://gentoo/${MY_P}-ipw2100.diff.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gsm pcap ssl"

DEPEND="sys-apps/sed"
RDEPEND="gsm? ( sys-apps/pcsc-lite )
		pcap? ( net-libs/libpcap
				dev-libs/libdnet )
		ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${WORKDIR}/${MY_P}-ipw2100.diff

	sed -i "s:madwifi/wpa::" ${S}/Makefile

	# Use pcap and libdnet if we have it.
	if use pcap; then
		sed -i "s:^#CFLAGS\(.*\):CFLAGS\1:" ${S}/Makefile
		sed -i "s:^#LIBS\(.*\):LIBS\1:" ${S}/Makefile
	fi

	cp ${FILESDIR}/${P}-config ${S}/.config || die

	if use ssl; then
		echo "CONFIG_EAP_TLS=y" >> ${S}/.config
		echo "CONFIG_EAP_PEAP=y" >> ${S}/.config
		echo "CONFIG_EAP_TTLS=y" >> ${S}/.config
	fi

	if use gsm; then
		echo "CONFIG_PCSC=y" >> ${S}/.config
	fi
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin wpa_cli wpa_passphrase wpa_supplicant

	dodoc ChangeLog COPYING developer.txt eap_testing.txt README todo.txt
	dodoc doc/wpa_supplicant.fig

	insinto /etc
	newins wpa_supplicant.conf wpa_supplicant.conf.example

	exeinto /etc/init.d
	newexe ${FILESDIR}/${MY_P}-init.d wpa_supplicant

	insinto /etc/conf.d
	newins ${FILESDIR}/${MY_P}-conf.d wpa_supplicant
}
