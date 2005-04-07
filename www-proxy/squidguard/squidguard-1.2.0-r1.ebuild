# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/squidguard/squidguard-1.2.0-r1.ebuild,v 1.8 2005/04/07 21:57:30 cryos Exp $

inherit eutils

MY_P=squidGuard-${PV}
DESCRIPTION="Combined filter, redirector and access controller plugin for Squid."
HOMEPAGE="http://www.squidguard.org"
SRC_URI="http://ftp.teledanmark.no/pub/www/proxy/squidGuard/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64 ~amd64"
IUSE=""

RDEPEND="www-proxy/squid
	>=sys-libs/db-2"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A} || die "unpack problem"
	cd ${S}
	epatch ${FILESDIR}/${P}-db4.patch  || die
	epatch ${FILESDIR}/${P}-db41.patch || die
	epatch ${FILESDIR}/${P}-db42.patch || die

	autoconf || die "autoconf problem"
}

src_compile() {
	econf \
		--with-sg-config=/etc/squidGuard/squidGuard.conf \
		--with-sg-logdir=/var/log/squidGuard \
		|| die "configure problem"

	mv src/Makefile src/Makefile.orig
	sed <src/Makefile.orig >src/Makefile \
		-e "s|logdir\t= /var/log/squidGuard|logdir\t= ${D}/var/log/squidGuard|" \
		-e "s|cfgdir\t= /etc/squidGuard|cfgdir\t= ${D}/etc/squidGuard|"

	emake || die "compile problem"
}

src_install() {
	make prefix=${D}/usr install

	dodir /var/log/squidGuard
	fowners squid:squid /var/log/squidGuard

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
	einfo "To use squidGuard, you should add the following line to your"
	einfo "/etc/squid/squid.conf:"
	einfo ""
	einfo "\tredirect_program /usr/bin/squidGuard"
	einfo ""
	einfo "Remember to edit /etc/squidGuard/squidGuard.conf first!"
	einfo "Examples can be found in /etc/squidGuard/sample/"
}
