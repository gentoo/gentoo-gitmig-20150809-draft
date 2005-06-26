# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/telnet-bsd/telnet-bsd-1.2.ebuild,v 1.2 2005/06/26 15:37:23 corsair Exp $

inherit eutils

DESCRIPTION="Telnet and telnetd ported from OpenBSD with IPv6 support"
HOMEPAGE="ftp://ftp.suse.com/pub/people/kukuk/ipv6/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/ipv6/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~sparc ~x86"
IUSE="nls"

DEPEND="!net-misc/netkit-telnetd"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto /etc/xinetd.d
	newins "${FILESDIR}"/telnetd.xinetd telnetd
	dodoc README THANKS NEWS AUTHORS ChangeLog INSTALL
}
