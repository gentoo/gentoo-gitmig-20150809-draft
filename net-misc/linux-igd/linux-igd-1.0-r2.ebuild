# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linux-igd/linux-igd-1.0-r2.ebuild,v 1.8 2012/01/28 01:05:40 ssuominen Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Deamon that emulates Microsoft's Internet Connection Sharing (ICS) for UPnP-aware clients"
HOMEPAGE="http://linux-igd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN/-}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=net-libs/libupnp-1.4.1"
RDEPEND="${DEPEND}
	net-firewall/iptables"

S=${WORKDIR}/${PN/-}-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-{build,include}.patch
}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}"/upnpd.initd-${PVR} upnpd
	newconfd "${FILESDIR}"/upnpd.confd-${PVR} upnpd

	dodoc CHANGES TODO INSTALL doc/*
}

pkg_postinst() {
	elog "Make sure your firewall allows routing of packages to:"
	elog " 239.0.0.0/255.0.0.0"
}
