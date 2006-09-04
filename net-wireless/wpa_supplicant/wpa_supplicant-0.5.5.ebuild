# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/wpa_supplicant-0.5.5.ebuild,v 1.2 2006/09/04 13:37:17 uberlord Exp $

inherit eutils toolchain-funcs

DESCRIPTION="IEEE 802.1X/WPA supplicant for secure wireless transfers"
HOMEPAGE="http://hostap.epitest.fi/wpa_supplicant/"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"
LICENSE="|| ( GPL-2 BSD )"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus gsm madwifi qt3 qt4 readline ssl kernel_linux kernel_FreeBSD"

RDEPEND="dbus? ( sys-apps/dbus )
		gsm? ( sys-apps/pcsc-lite )
		qt4? ( =x11-libs/qt-4* )
		!qt4? ( qt3? ( =x11-libs/qt-3* ) )
		readline? ( sys-libs/ncurses sys-libs/readline )
		ssl? ( dev-libs/openssl )
		kernel_linux? ( madwifi? ( || ( net-wireless/madwifi-ng net-wireless/madwifi-old ) ) )
		!kernel_linux? ( net-libs/libpcap )"
DEPEND="sys-apps/sed
		${RDEPEND}"

pkg_setup() {
	if use qt3 && use qt4; then
		einfo "You have USE=\"qt3 qt4\" selected, defaulting to USE=\"qt4\""
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix QT4 support, #146177 thanks to Horst Schirmeier.
	epatch "${FILESDIR}/${P}-qt4.patch"

	# net/bpf.h needed for net-libs/libpcap on Gentoo FreeBSD
	sed -i \
		-e "s:\(#include <pcap\.h>\):#include <net/bpf.h>\n\1:" \
		l2_packet_freebsd.c || die

	# toolchain setup
	echo "CC = $(tc-getCC)" > .config

	# basic setup
	echo "CONFIG_CTRL_IFACE=y" >> .config
	echo "CONFIG_BACKEND=file" >> .config

	# basic authentication methods
	echo "CONFIG_EAP_GTC=y"         >> .config
	echo "CONFIG_EAP_MD5=y"         >> .config
	echo "CONFIG_EAP_OTP=y"         >> .config
	echo "CONFIG_EAP_PAX=y"         >> .config
	echo "CONFIG_EAP_PSK=y"         >> .config
	echo "CONFIG_EAP_TLV=y"         >> .config
	echo "CONFIG_IEEE8021X_EAPOL=y" >> .config
	echo "CONFIG_PKCS12=y"          >> .config
	echo "CONFIG_PEERKEY=y"         >> .config

	if use dbus ; then
		echo "CONFIG_CTRL_IFACE_DBUS=y" >> .config
	fi

	if use gsm ; then
		# smart card authentication
		echo "CONFIG_EAP_SIM=y" >> .config
		echo "CONFIG_EAP_AKA=y" >> .config
		echo "CONFIG_PCSC=y"    >> .config
	fi

	if use readline ; then
		# readline/history support for wpa_cli
		echo "CONFIG_READLINE=y" >> .config
	fi

	if use ssl ; then
		# SSL authentication methods
		echo "CONFIG_EAP_LEAP=y"     >> .config
		echo "CONFIG_EAP_MSCHAPV2=y" >> .config
		echo "CONFIG_EAP_PEAP=y"     >> .config
		echo "CONFIG_EAP_TLS=y"      >> .config
		echo "CONFIG_EAP_TTLS=y"     >> .config
		echo "CONFIG_SMARTCARD=y"    >> .config
	fi

	if use kernel_linux ; then
		# Linux specific drivers
		echo "CONFIG_DRIVER_ATMEL=y"       >> .config
		echo "CONFIG_DRIVER_HOSTAP=y"      >> .config
		echo "CONFIG_DRIVER_IPW=y"         >> .config
		echo "CONFIG_DRIVER_NDISWRAPPER=y" >> .config
		echo "CONFIG_DRIVER_PRISM54=y"     >> .config
		echo "CONFIG_DRIVER_WEXT=y"        >> .config
		echo "CONFIG_DRIVER_WIRED=y"       >> .config

		if use madwifi ; then
			# Add include path for madwifi-driver headers
			echo "CFLAGS += -I${ROOT}/usr/include/madwifi" >> .config
			echo "CONFIG_DRIVER_MADWIFI=y"                 >> .config
		fi
	fi

	if use kernel_FreeBSD ; then
		# FreeBSD specific driver
		echo "CONFIG_DRIVER_BSD=y" >> .config
	fi

	# people seem to take the example configuration file too literally
	# bug #102361
	sed -i \
		-e "s:^\(opensc_engine_path\):#\1:" \
		-e "s:^\(pkcs11_engine_path\):#\1:" \
		-e "s:^\(pkcs11_module_path\):#\1:" \
		wpa_supplicant.conf || die

	# Change configuration to match Gentoo locations, #143750
	sed -i \
		-e "s:/usr/lib/opensc:/usr/$(get_libdir):" \
		-e "s:/usr/lib/pkcs11:/usr/$(get_libdir):" \
		wpa_supplicant.conf || die
}

src_compile() {
	emake || die "emake failed"

	if use qt4 ; then
		qmake -o "${S}"/wpa_gui-qt4/Makefile "${S}"/wpa_gui-qt4/wpa_gui.pro
		cd "${S}"/wpa_gui-qt4
		emake || die "emake wpa_gui-qt4 failed"
	elif use qt3 ; then
		[[ -d ${QTDIR}/etc/settings ]] && addwrite "${QTDIR}"/etc/settings
		/usr/qt/3/bin/qmake -o "${S}"/wpa_gui/Makefile "${S}"/wpa_gui/wpa_gui.pro
		cd "${S}"/wpa_gui
		emake || die "emake wpa_gui failed"
	fi
}

src_install() {
	into /
	dosbin wpa_supplicant
	dobin wpa_cli wpa_passphrase

	exeinto /etc/wpa_supplicant/
	newexe "${FILESDIR}"/wpa_cli.sh wpa_cli.sh

	if use qt4 ; then
		into /usr
		dobin wpa_gui-qt4/wpa_gui
	elif use qt3 ; then
		into /usr
		dobin wpa_gui/wpa_gui
	fi

	if use qt3 || use qt4; then
		make_desktop_entry wpa_gui "WPA_Supplicant Administration GUI"
	fi

	dodoc ChangeLog COPYING eap_testing.txt README todo.txt
	newdoc wpa_supplicant.conf wpa_supplicant.conf.example

	doman doc/docbook/*.8
	doman doc/docbook/*.5
}

pkg_postinst() {
	einfo "To use ${MY_P} you must create the configuration file"
	einfo "/etc/wpa_supplicant/wpa_supplicant.conf"
	einfo
	einfo "An example configuration file is available as"
	einfo "/usr/share/doc/${PF}/wpa_supplicant.conf.example.gz"

	if use madwifi; then
		einfo
		einfo "This package now compiles against the headers installed by"
		einfo "the madwifi driver. You should reemerge ${PN} after"
		einfo "upgrading your madwifi driver."
	fi
}
