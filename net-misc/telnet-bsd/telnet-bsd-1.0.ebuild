# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/telnet-bsd/telnet-bsd-1.0.ebuild,v 1.18 2004/12/09 19:54:49 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Telnet and telnetd ported from OpenBSD with IPv6 support"
HOMEPAGE="ftp://ftp.suse.com/pub/people/kukuk/ipv6/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/ipv6/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc sparc x86"
IUSE="nls"

DEPEND="virtual/libc
	!net-misc/netkit-telnetd"

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SOURCE="${FILESDIR}" epatch
	sed -i \
		-e 's:destdir=:destdir=$(DESTDIR):' \
		po/Makefile.in.in \
		|| die "sed failed"
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README THANKS NEWS AUTHORS ChangeLog INSTALL
}
