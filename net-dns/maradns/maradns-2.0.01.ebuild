# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/maradns/maradns-2.0.01.ebuild,v 1.1 2011/01/24 13:22:58 matsuu Exp $

EAPI="3"
inherit eutils toolchain-funcs

DESCRIPTION="Proxy DNS server with permanent caching"
HOMEPAGE="http://www.maradns.org/"
SRC_URI="http://www.maradns.org/download/${PV%.*}/${PV}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ipv6"

DEPEND="dev-lang/perl"

src_prepare() {
	sed -i \
		-e "s:PREFIX/man:PREFIX/share/man:" \
		-e "s:PREFIX/doc/maradns-\$VERSION:PREFIX/share/doc/${PF}:" \
		build/install.locations || die
	sed -i \
		-e "s:-O2:\$(CFLAGS) \$(LDFLAGS):" \
		-e "s:make:\$(MAKE):g" \
		-e "s:\$(CC):$(tc-getCC):g" \
		build/Makefile.linux || die
	sed -e "/provide dns/d" "${FILESDIR}/maradns.rc6" > "${T}/maradns.rc6" || die
}

src_configure() {
	local myconf

	use ipv6 && myconf="${myconf} --ipv6"

	./configure ${myconf} # || die
}

src_install() {
	dosbin server/maradns || die

	dosbin tcp/zoneserver || die

	dobin tcp/getzone tcp/fetchzone tools/askmara tools/duende || die

	doman doc/en/man/*.[1-9] || die

	dodoc maradns.gpg.key || die
	dodoc doc/en/{QuickStart,README,*.txt} || die
	dohtml doc/en/*.html || die
	dohtml -r doc/en/webpage || die
	docinto examples; dodoc doc/en/examples/example_* || die

	insinto /etc; newins doc/en/examples/example_mararc mararc || die
	insinto /etc/maradns; newins doc/en/examples/example_csv2 db.example.net || die
	keepdir /etc/maradns/logger || die

	newinitd "${T}"/maradns.rc6 maradns || die
	newinitd "${FILESDIR}"/zoneserver.rc6 zoneserver || die
}

pkg_postinst() {
	enewgroup maradns 99
	enewuser duende 66 -1 -1 maradns
	enewuser maradns 99 -1 -1 maradns
}
