# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpv6/dhcpv6-0.10_pre20060828.ebuild,v 1.1 2006/08/28 07:54:27 vapier Exp $

inherit flag-o-matic

MY_P="dhcp-${PV/_pre*}"
SNAP=${PV/*_pre}
DESCRIPTION="Server and client for DHCPv6"
HOMEPAGE="http://sourceforge.net/projects/dhcpv6/"
SRC_URI="mirror://sourceforge/dhcpv6/${MY_P}.tgz
	mirror://gentoo/${PN}-cvs${SNAP}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="static"

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PN}-cvs${SNAP}.patch
}

src_compile() {
	econf || die
	use static && append-ldflags -static
	emake -j1 || die
}

src_install() {
	einstall || die
	dodoc Install ReadMe docs/*.txt *.conf
	dodir /var/lib/dhcpv6
	newinitd "${FILESDIR}"/dhcp6s.rc dhcp6s || die
}
