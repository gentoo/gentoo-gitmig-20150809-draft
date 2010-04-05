# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/maradns/maradns-1.2.12.10.ebuild,v 1.4 2010/04/05 17:45:55 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Proxy DNS server with permanent caching"
HOMEPAGE="http://www.maradns.org/"
SRC_URI="http://www.maradns.org/download/1.2/${PV}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:PREFIX/man:PREFIX/share/man:" \
		-e "s:PREFIX/doc/maradns-\$VERSION:PREFIX/share/doc/${PF}:" \
		build/install.locations || die
	sed -i -e "s:-O2:${CFLAGS}:" build/Makefile.linux || die
}

src_compile() {
	./configure || die
	emake CC="$(tc-getCC)" || die "compile problem"
}

src_install() {
	dosbin server/maradns
	# use authonly && newsbin server/maradns.authonly maradns
	dosbin tcp/zoneserver

	dobin tcp/getzone tcp/fetchzone tools/askmara tools/duende

	doman doc/en/man/*.[1-9]

	dodoc maradns.gpg.key
	dodoc doc/en/{QuickStart,README,*.txt}
	dohtml doc/en/*.html
	dohtml -r doc/en/webpage
	docinto examples; dodoc doc/en/examples/example_*

	insinto /etc; newins doc/en/examples/example_mararc mararc
	insinto /etc/maradns; newins doc/en/examples/example_csv2 db.example.net
	keepdir /etc/maradns/logger

	newinitd "${FILESDIR}"/maradns.rc6 maradns
	newinitd "${FILESDIR}"/zoneserver.rc6 zoneserver
}

pkg_postinst() {
	enewuser maradns 99 -1 /var/empty daemon
}
