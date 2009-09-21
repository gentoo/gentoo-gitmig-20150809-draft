# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miniupnpd/miniupnpd-1.4_pre20090921.ebuild,v 1.1 2009/09/21 17:46:39 gurligebis Exp $

EAPI=2
inherit eutils linux-info toolchain-funcs

MY_PV=20090921
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="MiniUPnP IGD Daemon"
SRC_URI="http://miniupnp.free.fr/files/${PN}-${MY_PV}.tar.gz"
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
	epatch "${FILESDIR}/${PN}-1.3-iptables_path.diff"
	epatch "${FILESDIR}/${PN}-1.3-Makefile_fix.diff"
	sed -i -e "s#^CFLAGS = #CFLAGS = -I${KV_OUT_DIR}/include #" Makefile
	emake config.h
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	einstall PREFIX="${D}" STRIP="true" || die "einstall failed"

	newinitd "${FILESDIR}"/${PN}-1.3-init.d ${PN}
	newconfd "${FILESDIR}"/${PN}-1.3-conf.d ${PN}
}

pkg_postinst() {
	elog "Please correct the external interface in the top of the two"
	elog "scripts in /etc/miniupnpd and edit the config file in there too"
}
