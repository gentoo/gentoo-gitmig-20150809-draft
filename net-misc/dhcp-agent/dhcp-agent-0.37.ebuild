# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp-agent/dhcp-agent-0.37.ebuild,v 1.8 2004/07/15 02:43:30 agriffis Exp $

DESCRIPTION="dhcp-agent is a portable UNIX Dynamic Host Configuration suite"
HOMEPAGE="http://dhcp-agent.sourceforge.net/"
SRC_URI="mirror://sourceforge/dhcp-agent/${P}.tar.gz"
SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND=">=dev-libs/libdnet-1.4
		>=net-libs/libpcap-0.7.1"

src_compile() {

	econf || die
	emake CFLAGS="${CFLAGS} -Wall -g" || die

}

src_install() {

	einstall || die

	dodoc README THANKS TODO UPGRADING CAVEATS

}
