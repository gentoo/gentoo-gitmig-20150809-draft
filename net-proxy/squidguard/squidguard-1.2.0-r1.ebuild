# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/squidguard/squidguard-1.2.0-r1.ebuild,v 1.4 2006/09/06 20:16:12 mrness Exp $

inherit eutils

DESCRIPTION="Combined filter, redirector and access controller plugin for Squid."
HOMEPAGE="http://www.squidguard.org"
SRC_URI="http://ftp.teledanmark.no/pub/www/proxy/squidGuard/squidGuard-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="net-proxy/squid
	>=sys-libs/db-2"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/squidGuard-${PV}"

src_unpack() {
	unpack ${A} || die "unpack problem"

	epatch "${FILESDIR}/${P}-db4.patch"
}

src_compile() {
	econf \
		--with-sg-config=/etc/squidGuard/squidGuard.conf \
		--with-sg-logdir=/var/log/squidGuard \
		|| die "configure problem"

	sed -i \
		-e "s|logdir\t= /var/log/squidGuard|logdir\t= ${D}/var/log/squidGuard|" \
		-e "s|cfgdir\t= /etc/squidGuard|cfgdir\t= ${D}/etc/squidGuard|" \
		src/Makefile

	emake || die "compile problem"
}

src_install() {
	make prefix="${D}/usr" install

	dodir /var/log/squidGuard
	fowners squid:squid /var/log/squidGuard

	insinto /etc/squidGuard/sample
	doins "${FILESDIR}"/squidGuard.conf.*
	insinto /etc/squidGuard/sample/db
	doins "${FILESDIR}"/blockedsites

	dodoc ANNOUNCE CHANGELOG README
	dohtml doc/*.html
	docinto text
	dodoc doc/*.txt
}

pkg_postinst() {
	einfo "To use squidGuard, you should add the following line to your"
	einfo "/etc/squid/squid.conf:"
	einfo ""
	einfo "\tredirect_program /usr/bin/squidGuard"
	einfo ""
	einfo "Remember to edit /etc/squidGuard/squidGuard.conf first!"
	einfo "Examples can be found in /etc/squidGuard/sample/"
}
