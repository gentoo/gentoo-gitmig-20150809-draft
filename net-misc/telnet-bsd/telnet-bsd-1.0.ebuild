# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/telnet-bsd/telnet-bsd-1.0.ebuild,v 1.12 2004/02/05 23:41:31 vapier Exp $

inherit eutils
EPATCH_SOURCE="${FILESDIR}"

DESCRIPTION="Telnet and telnetd ported from OpenBSD with IPv6 support"
HOMEPAGE="ftp://ftp.suse.com/pub/people/kukuk/ipv6/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/ipv6/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha hppa ~amd64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch
}

src_install() {
	einstall || die
	dodoc README THANKS NEWS AUTHORS ChangeLog INSTALL
}
