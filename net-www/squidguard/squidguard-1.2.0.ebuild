# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/squidguard/squidguard-1.2.0.ebuild,v 1.2 2003/02/13 15:44:09 vapier Exp $

DESCRIPTION="Combined filter, redirector and access controller plugin for Squid."
HOMEPAGE="http://www.squidguard.com"
SRC_URI="ftp://ftp.teledanmark.no/pub/www/proxy/squidGuard/squidGuard-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="net-www/squid
	>=sys-libs/db-2"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/squidGuard-${PV}"

src_compile() {
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	make prefix=${D}/usr install

	insinto /etc/squidGuard/sample
	doins ${FILESDIR}/squidGuard.conf.*
	insinto /etc/squidGuard/sample/db
	doins ${FILESDIR}/blockedsites

	dodoc ANNOUNCE CHANGELOG COPYING GPL README
	dohtml doc/*.html
	docinto text
	dodoc doc/*.txt
}

pkg_postinst() {
	ewarn "You must add the following line to your /etc/squid/squid.conf:"
	ewarn ""
	ewarn "\tredirect_program /usr/bin/squidGuard -c /etc/squidGuard/squidGuard.conf"
	ewarn ""
	ewarn "Remember to edit /etc/squidGuard/squidGuard.conf first!"
	ewarn "Examples can be found in /etc/squidGuard/sample/"
}
