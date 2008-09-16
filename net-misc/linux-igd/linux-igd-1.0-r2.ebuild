# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linux-igd/linux-igd-1.0-r2.ebuild,v 1.7 2008/09/16 06:53:22 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Deamon that emulates Microsoft's Internet Connection Sharing (ICS) for UPnP-aware clients"
HOMEPAGE="http://linux-igd.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-igd/linuxigd-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=net-libs/libupnp-1.4.1"
RDEPEND="${DEPEND}
	net-firewall/iptables"

S=${WORKDIR}/linuxigd-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	tc-export CC
	emake || die "compile failed"
}

src_install() {
	emake install DESTDIR="${D}" || die

	newinitd "${FILESDIR}"/upnpd.initd-${PVR} upnpd
	newconfd "${FILESDIR}"/upnpd.confd-${PVR} upnpd

	dodoc CHANGES TODO INSTALL doc/*
}

pkg_postinst() {
	einfo "Make sure your firewall allows routing of packages"
	einfo "to 239.0.0.0/255.0.0.0 correctly."
}
