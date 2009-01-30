# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miniupnpd/miniupnpd-20090129.ebuild,v 1.1 2009/01/30 00:05:18 gurligebis Exp $

EAPI="2"

inherit eutils linux-info

DESCRIPTION="MiniUPnP IGD Daemon"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"
HOMEPAGE="http://miniupnp.free.fr/"
LICENSE="miniupnpd"

KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND=">=net-firewall/iptables-1.4.2-r1
	sys-apps/lsb-release"
RDEPEND="${DEPEND}"

src_prepare() {
	mv Makefile.linux Makefile
	epatch "${FILESDIR}/${P}-iptables.diff"
	epatch "${FILESDIR}/${P}-iptables_path.diff"
	sed -i -e "s#^CFLAGS = #CFLAGS = -I${KV_OUT_DIR}/include #" Makefile
		# we don't use netfilter/Makefile
	gmake config.h
}

src_install () {
	PREFIX="${D}" einstall || die

	newinitd "${FILESDIR}/${P}-init.d" "${PN}"
	newconfd "${FILESDIR}/${P}-conf.d" "${PN}"
}

pkg_postinst() {
	elog "Please correct the external interface in the top of the two"
	elog "scripts in /etc/miniupnpd and edit the config file in there too"
}
