# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/telnet-bsd/telnet-bsd-1.0.ebuild,v 1.16 2004/11/03 00:22:36 vapier Exp $

inherit eutils

DESCRIPTION="Telnet and telnetd ported from OpenBSD with IPv6 support"
HOMEPAGE="ftp://ftp.suse.com/pub/people/kukuk/ipv6/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/ipv6/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc sparc x86"
IUSE=""

DEPEND="virtual/libc
	!net-misc/netkit-telnetd"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SOURCE="${FILESDIR}" epatch
}

src_install() {
	einstall || die
	dodoc README THANKS NEWS AUTHORS ChangeLog INSTALL
}
