# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipp2p/ipp2p-0.8.2-r4.ebuild,v 1.9 2009/04/10 22:25:36 mrness Exp $

EAPI="2"

inherit linux-mod eutils

DESCRIPTION="Netfilter module for dealing with P2P Applications."
HOMEPAGE="http://www.ipp2p.org/index_en.html"
SRC_URI="http://www.ipp2p.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/modutils
	 net-firewall/iptables"

DEPEND="${RDEPEND}
	virtual/linux-sources"

pkg_setup() {
	CONFIG_CHECK="NETFILTER"
	NETFILTER_ERROR="Your kernel is not configured to support Netfilter."
	MODULE_NAMES="ipt_ipp2p(${PN}:${S}:${S})"

	linux-mod_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-kernel-2.6.22.patch
	convert_to_m Makefile

	sed -i -e "s/^IPTABLES_VERSION/#IPTABLES_VERSION/" Makefile

	has_version '>=net-firewall/iptables-1.3.6' || return 0
	sed -i -e "s/ld -shared/\$\(CC\) -shared/" Makefile

	has_version '>=net-firewall/iptables-1.4.0' || return 0
	epatch "${FILESDIR}"/${P}-iptables-1.4.0.patch

	has_version '>=net-firewall/iptables-1.4.1' || return 0
	epatch "${FILESDIR}"/${P}-iptables-1.4.1.patch

	has_version '>=net-firewall/iptables-1.4.3' || return 0
	epatch "${FILESDIR}"/${P}-iptables-1.4.3.patch
}

src_compile() {
	local IPTABLES_VERSION="$(/sbin/iptables --version | cut -f2 -dv)"
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" \
	    IPTABLES_SRC="/usr" IPTABLES_VERSION="${IPTABLES_VERSION}" libipt_ipp2p.so \
	    || die "Failed to build iptables module"

	local myARCH="${ARCH}"
	ARCH="$(tc-arch-kernel)"
	emake KERNEL_SRC="${KV_DIR}" \
	    IPTABLES_SRC="/usr" IPTABLES_VERSION="${IPTABLES_VERSION}" \
	    || die "Failed to build kernel module."
	ARCH="${myARCH}"
}

src_install() {
	if has_version '>=net-firewall/iptables-1.4.1' ; then
		exeinto /$(get_libdir)/xtables
	else
		exeinto /$(get_libdir)/iptables
	fi
	doexe libipt_ipp2p.so

	dodoc README
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
