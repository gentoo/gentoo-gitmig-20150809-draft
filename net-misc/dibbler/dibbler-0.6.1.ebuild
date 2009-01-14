# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dibbler/dibbler-0.6.1.ebuild,v 1.3 2009/01/14 05:04:33 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Portable DHCPv6 implementation (server, client and relay)"
HOMEPAGE="http://klub.com.pl/dhcpv6/"
SRC_URI="http://klub.com.pl/dhcpv6/dibbler/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~x86"
IUSE="doc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^COPTS/s:$: $(CPPFLAGS):' \
		Makefile.inc || die
	append-cppflags -D_GNU_SOURCE #240916
}

src_compile() {
	emake -j1 || die "Compilation failed"
}

src_install() {
	dosbin dibbler-{client,relay,server} || die
	doman doc/man/dibbler-{client,relay,server}.8
	dodoc CHANGELOG RELNOTES

	insinto /etc/dibbler
	doins *.conf
	dodir /var/lib/dibbler

	doinitd "${FILESDIR}"/dibbler-{client,relay,server}

	use doc && dodoc doc/dibbler-{devel,user}.pdf
}

pkg_postinst() {
	einfo "Make sure that you modify client.conf, server.conf and/or relay.conf"
	einfo "to suit your needs. They are stored in /etc/dibbler."
}
