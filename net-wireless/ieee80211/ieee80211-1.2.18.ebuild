# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ieee80211/ieee80211-1.2.18.ebuild,v 1.1 2007/09/09 08:47:49 phreak Exp $

inherit eutils linux-mod

# The following works with both pre-releases and releases
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Generic IEEE 802.11 network subsystem for Linux"
HOMEPAGE="http://ieee80211.sourceforge.net"
#SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=""

IUSE="debug"
BUILD_TARGETS="modules"
MODULE_NAMES="ieee80211(net/ieee80211:)
			ieee80211_crypt(net/ieee80211:)
			ieee80211_crypt_wep(net/ieee80211:)
			ieee80211_crypt_ccmp(net/ieee80211:)
			ieee80211_crypt_tkip(net/ieee80211:)"

CONFIG_CHECK="NET_RADIO CRYPTO_ARC4 CRYPTO_MICHAEL_MIC CRC32 !IEEE80211"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_CRYPTO_ARC4="${P} requires support for ARC4 cipher algorithm (CONFIG_CRYPTO_ARC4)."
ERROR_CRYPTO_MICHAEL_MIC="${P} requires support for Michael MIC keyed digest algorithm (CONFIG_CRYPTO_MICHAEL_MIC)."
ERROR_CRC32="${P} requires support for CRC32 functions (CONFIG_CRC32)."
ERROR_IEEE80211="${P} requires the in-kernel version of the IEEE802.11 subsystem to be disabled (CONFIG_IEEE80211)"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	if [[ -f ${KV_DIR}/include/net/ieee80211.h ]] || \
		[[ -f ${KV_OUT_DIR}/include/config/ieee80211.h ]] || \
		egrep -q "^#(un)?def.*(CONFIG_IEEE80211.*)" ${KV_OUT_DIR}/include/linux/autoconf.h; then
		eerror
		eerror "Your kernel source contains an incompatible version of the"
		eerror "ieee80211 subsystem, which needs to be removed before"
		eerror "${P} can be installed. This can be accomplished by running:"
		eerror
		eerror "  # /bin/sh ${FILESDIR}/remove-old ${KV_DIR}"
		if [ "${KV_DIR}" != "${KV_OUT_DIR}" ]; then
			eerror "  # /bin/sh ${FILESDIR}/remove-old ${KV_OUT_DIR}"
		fi
		eerror
		eerror "Please note that this will make it impossible to use some of the"
		eerror "in-kernel IEEE 802.11 wireless LAN drivers (eg. orinoco)."
		eerror
		die "Incompatible in-kernel ieee80211 subsystem detected"
	fi

	if ! (linux_chkconfig_present CRYPTO_AES_586 || \
		  linux_chkconfig_present CRYPTO_AES_X86_64 || \
		  linux_chkconfig_present CRYPTO_AES); then
		eerror "${P} requires support for AES cipher algorithms."
		die "CONFIG_CRYPTO_AES{_586,_X86_64} support not detected"
	fi

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR}"
}

src_unpack() {
	local debug="n"

	unpack ${A}
	cd "${S}"

	use debug && debug="y"
	sed -i \
		-e "s:^\(CONFIG_IEEE80211_DEBUG\)=.*:\1=${debug}:" \
		"${S}"/Makefile || die
}

src_install() {
	linux-mod_src_install

	insinto /usr/include/net
	doins net/*.h

	dodoc CHANGES
}
