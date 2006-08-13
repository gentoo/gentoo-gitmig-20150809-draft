# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/maradns/maradns-1.2.03.3.ebuild,v 1.2 2006/08/13 00:48:10 matsuu Exp $

inherit eutils

DESCRIPTION="Proxy DNS server with permanent caching"
HOMEPAGE="http://www.maradns.org/"
SRC_URI="mirror://sourceforge/maradns/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

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
	emake || die "compile problem"
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
	docinto misc

	insinto /etc; newins doc/en/examples/example_mararc mararc
	insinto /etc/maradns; newins doc/en/examples/example_csv2 db.example.net
	keepdir /etc/maradns/logger

	builddir/mara.startup maradns
	builddir/zoneserver.startup maradns.zoneserver
	newinitd "${FILESDIR}"/maradns.rc6 maradns
	newinitd "${FILESDIR}"/zoneserver.rc6 zoneserver
}

pkg_postinst() {
	enewuser maradns 99 -1 /var/empty daemon
}
