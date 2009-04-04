# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpv6/dhcpv6-1.0.22.ebuild,v 1.2 2009/04/04 19:19:14 deathwing00 Exp $

inherit flag-o-matic

DESCRIPTION="Server and client for DHCPv6"
HOMEPAGE="https://fedorahosted.org/dhcpv6/"
SRC_URI="https://fedorahosted.org/releases/d/h/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="static"

DEPEND=">=dev-libs/libnl-1.1"
RDEPEND="${DEPEND}"

src_compile() {
	use static && append-ldflags -static
	econf || die
	emake || die
}

mkd() {
	local x=$1 X=$2 i=$3
	sed \
		-e "s:6x:6${x}:g" \
		-e "s:6X:6${X}:g" \
		"${FILESDIR}"/dhcp6x.${i}d.in > dhcp6${x}.${i}d
	new${i}d dhcp6${x}.${i}d dhcp6${x}
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO RFC*
	dodir /var/lib/dhcpv6

	rm -rf "${D}"/etc/{rc.d,sysconfig}
	mkd s S init
	mkd s S conf
	mkd r R init
	mkd r R conf
}
