# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/gld/gld-1.4.ebuild,v 1.5 2004/11/13 12:44:34 slarti Exp $

DESCRIPTION="A standalone anti-spam greylisting algorithm on top of Postfix"
HOMEPAGE="http://www.gasmi.net/gld.html"
SRC_URI="http://www.gasmi.net/down/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc"
IUSE=""
DEPEND="virtual/libc
	dev-db/mysql
	sys-libs/zlib
	>=dev-libs/openssl-0.9.6"
RDEPEND="${DEPEND}
	>=mail-mta/postfix-2.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/Makefile.in ${S}/Makefile.in
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin gld

	insinto /etc
	newins gld.conf gld.conf.sample

	dodoc HISTORY LICENSE README

	dodir /usr/share/doc/${PF}/sql
	insinto /usr/share/doc/${PF}/sql
	doins tables.sql

	newinitd ${FILESDIR}/gld.rc gld
}

pkg_postinst() {
	echo
	einfo "Please read /usr/share/doc/${PF}/README.gz for details on how to setup"
	einfo "gld."
	echo
	einfo "The tables.sql file is located at /usr/share/doc/${PF}/sql/tables.sql."
	echo
}
