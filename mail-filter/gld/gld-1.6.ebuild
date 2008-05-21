# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/gld/gld-1.6.ebuild,v 1.7 2008/05/21 16:03:03 dev-zero Exp $

DESCRIPTION="A standalone anti-spam greylisting algorithm on top of Postfix"
HOMEPAGE="http://www.gasmi.net/gld.html"
SRC_URI="http://www.gasmi.net/down/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="postgres"
# Not adding a mysql USE flag. The package defaults to it, so we will too.
DEPEND="virtual/libc
	sys-libs/zlib
	>=dev-libs/openssl-0.9.6
	postgres? ( virtual/postgresql-server )
	!postgres? ( virtual/mysql )"
RDEPEND="${DEPEND}
	>=mail-mta/postfix-2.1"

src_unpack() {
	unpack ${A}
	cd ${S}
#	cp ${FILESDIR}/Makefile.in ${S}/Makefile.in
}

src_compile() {
	# It's kind of weird. $(use_with postgres pgsql) won't work...
	if use postgres ; then
		myconf="${myconf} --with-pgsql"
	fi

	econf ${myconf} \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin gld

	insinto /etc
	newins gld.conf gld.conf.sample
	dosed 's:^LOOPBACKONLY=.*:LOOPBACKONLY=1:' /etc/gld.conf.sample
	dosed 's:^#USER=.*:USER=nobody:' /etc/gld.conf.sample
	dosed 's:^#GROUP=.*:GROUP=nobody:' /etc/gld.conf.sample

	dodoc HISTORY README*

	insinto /usr/share/${PN}/sql
	doins table*

	newinitd ${FILESDIR}/gld.rc gld
}

pkg_postinst() {
	elog
	elog "Please read /usr/share/doc/${PF}/README.gz for details on how to setup"
	elog "gld."
	elog
	elog "The sql files have been installed to /usr/share/${PN}/sql."
	elog
}
