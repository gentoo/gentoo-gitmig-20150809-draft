# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miniupnpd/miniupnpd-1.3.ebuild,v 1.2 2009/05/13 07:51:43 ssuominen Exp $

EAPI=2
inherit eutils linux-info toolchain-funcs

DESCRIPTION="MiniUPnP IGD Daemon"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"
HOMEPAGE="http://miniupnp.free.fr/"

LICENSE="miniupnpd"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-firewall/iptables-1.4.3
	sys-apps/lsb-release"
DEPEND="${RDEPEND}"

src_prepare() {
	mv Makefile.linux Makefile
	epatch "${FILESDIR}/${P}-iptables_path.diff"
	epatch "${FILESDIR}/${P}-Makefile_fix.diff"
	sed -i -e "s#^CFLAGS = #CFLAGS = -I${KV_OUT_DIR}/include #" Makefile
	emake config.h
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	einstall PREFIX="${D}" STRIP="true" || die "einstall failed"

	newinitd "${FILESDIR}"/${P}-init.d ${PN}
	newconfd "${FILESDIR}"/${P}-conf.d ${PN}
}

pkg_postinst() {
	elog "Please correct the external interface in the top of the two"
	elog "scripts in /etc/miniupnpd and edit the config file in there too"
}
