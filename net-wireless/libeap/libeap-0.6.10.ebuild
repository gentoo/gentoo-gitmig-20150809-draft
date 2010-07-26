# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libeap/libeap-0.6.10.ebuild,v 1.2 2010/07/26 22:39:29 alexxy Exp $

EAPI="2"

inherit eutils toolchain-funcs qt4

MY_PN="wpa_supplicant"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="libeap is library for wimax authorization"
HOMEPAGE="http://hostap.epitest.fi/wpa_supplicant/"
SRC_URI="http://hostap.epitest.fi/releases/${MY_PN}-${PV}.tar.gz"
LICENSE="|| ( GPL-2 BSD )"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x86? (
				dev-libs/libnl
				dev-libs/openssl
				)
		amd64? ( app-emulation/emul-linux-x86-baselibs )"
DEPEND="${RDEPEND}
		!net-wireless/wpa_supplicant[wimax]
		dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use amd64 && multilib_toolchain_setup x86
}

src_prepare() {
	epatch "${FILESDIR}/${MY_P}-generate-libeap-peer.patch"
}

src_compile() {
	emake -C src/eap_peer || die "emake failed"
}

src_install() {
		insinto /usr/include/eap_peer
		doins	src/utils/includes.h
		doins	src/utils/common.h
		doins	src/eap_peer/eap.h
		doins	src/common/defs.h
		doins	src/eap_peer/eap_methods.h
		doins	src/eap_peer/eap_config.h
		doins	src/utils/wpabuf.h
		doins	src/crypto/tls.h
		doins	src/utils/build_config.h
		doins	src/utils/os.h
		doins	src/utils/wpa_debug.h
		insinto /usr/include/eap_peer/eap_common
		doins src/eap_common/eap_defs.h || die
		insinto /usr/lib/pkgconfig
		doins src/eap_peer/libeap0.pc
		dolib.so src/eap_peer/libeap.so.0.0.0
		dosym /usr/$(get_libdir)/libeap.so.0.0.0 /usr/$(get_libdir)/libeap.so.0
}
