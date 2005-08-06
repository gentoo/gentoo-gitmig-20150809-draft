# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipp2p/ipp2p-0.7.4-r2.ebuild,v 1.2 2005/08/06 03:21:31 eradicator Exp $

IUSE=""

inherit linux-mod eutils

DESCRIPTION="Netfilter module for dealing with P2P Applications."
HOMEPAGE="http://www.ipp2p.org/index_en.html"
SRC_URI="http://www.ipp2p.org/downloads/${P}.tar.gz"

SLOT="${KV}"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND="virtual/modutils
	 >=net-firewall/iptables-1.2.11"

DEPEND="${RDEPEND}
	virtual/linux-sources"

pkg_setup() {
	CONFIG_CHECK="NETFILTER"
	NETFILTER_ERROR="Your kernel is not configured to support Netfilter."
	MODULE_NAMES="ipt_ipp2p(${PN}:${S}:${S})"

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}

	cd ${S}
	convert_to_m ${S}/Makefile
}

src_compile() {
	emake CFLAGS="${CFLAGS}" libipt_ipp2p.so || die "Failed to build iptables module"

	xarch="${ARCH}"
	unset ARCH
	emake KERNEL_SRC="${KV_DIR}" IPTABLES_SRC="${ROOT}/usr" IPTABLES_VERSION="$(${ROOT}/sbin/iptables --version | cut -f2 -dv)" IPTABLES_BIN="${ROOT}/sbin/iptables" || die "Failed to build kernel modle."
	ARCH="${xarch}"
}

src_install() {
	exeinto /$(get_libdir)/iptables
	doexe libipt_ipp2p.so

	dodoc README
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
