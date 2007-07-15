# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/charybdis/charybdis-1.1.0.ebuild,v 1.2 2007/07/15 06:24:03 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A non-monolithic ircd loosely based on ircd-ratbox"
HOMEPAGE="http://www.ircd-charybdis.org/"
SRC_URI="http://www.charybdis.be/release/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ipv6 ssl debug smallnet zlib static"

DEPEND="zlib? ( sys-libs/zlib )
		ssl? ( dev-libs/openssl )"

pkg_setup() {
	enewuser ircd
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/charybdis-1.1.0-paths.patch
}

src_compile() {
	econf \
		$(use_enable ipv6) \
		$(use_enable ssl openssl) \
		$(use_enable debug assert) \
		$(use_enable smallnet small-net) \
		$(use_enable zlib) \
		$(use_enable !static shared-modules) \
		--with-confdir=/etc/charybdis \
		--with-logdir=/var/log/charybdis \
		--with-helpdir=/usr/share/charybdis/help \
		--with-moduledir=/usr/lib/charybdis \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	newbin src/ircd ircd-charybdis
	dobin servlink/servlink || die "dobin failed"

	exeinto /usr/lib/charybdis
	doexe modules/core/*.so || die "doexe failed"
	exeinto /usr/lib/charybdis/autoload
	doexe modules/*.so || die "doexe failed"
	exeinto /usr/lib/charybdis/contrib
	doexe contrib/*.so || die "doexe failed"

	insinto /etc/charybdis
	doins doc/example.conf || die "doins failed"
	newins doc/example.conf ircd.conf
	doins doc/reference.conf || die "doins failed"

	dodoc doc/*.txt || die "dodoc failed"
	dodoc doc/*.conf || die "dodoc failed"
	dodoc doc/Tao-of-IRC.940110 || die "dodoc failed"

	keepdir /var/{lib,log,run}/charybdis || die "keepdir failed"
	fowners ircd:nobody /var/{lib,log,run}/charybdis || die "fowners failed"

	newinitd ${FILESDIR}/charybdis-ircd.initd charybdis-ircd || die "newinitd failed"
	newconfd ${FILESDIR}/charybdis-ircd.confd charybdis-ircd || die "newconfd failed"
}

pkg_postinst() {
	ewarn "You should probably edit /etc/charybdis/ircd.conf at this point."
}
