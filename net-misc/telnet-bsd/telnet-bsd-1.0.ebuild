# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/telnet-bsd/telnet-bsd-1.0.ebuild,v 1.15 2004/06/29 00:17:13 vapier Exp $

inherit eutils
EPATCH_SOURCE="${FILESDIR}"

DESCRIPTION="Telnet and telnetd ported from OpenBSD with IPv6 support"
HOMEPAGE="ftp://ftp.suse.com/pub/people/kukuk/ipv6/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/ipv6/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha hppa amd64"
IUSE=""

DEPEND="virtual/libc
	!net-misc/netkit-telnetd"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch
}

src_install() {
	einstall || die
	dodoc README THANKS NEWS AUTHORS ChangeLog INSTALL
}
