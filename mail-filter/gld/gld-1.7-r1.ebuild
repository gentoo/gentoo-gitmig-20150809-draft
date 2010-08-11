# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/gld/gld-1.7-r1.ebuild,v 1.1 2010/08/11 01:35:43 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="A standalone anti-spam greylisting algorithm on top of Postfix"
HOMEPAGE="http://www.gasmi.net/gld.html"
SRC_URI="http://www.gasmi.net/down/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="postgres"
# Not adding a mysql USE flag. The package defaults to it, so we will too.
DEPEND="sys-libs/zlib
	>=dev-libs/openssl-0.9.6
	postgres? ( dev-db/postgresql-server )
	!postgres? ( virtual/mysql )"

src_prepare() {
	sed -i gld.conf \
		-e 's:^LOOPBACKONLY=.*:LOOPBACKONLY=1:' \
		-e 's:^#USER=.*:USER=nobody:' \
		-e 's:^#GROUP=.*:GROUP=nobody:' \
		|| die "sed gld.conf failed"

	sed -i Makefile.in \
		-e '/ -c /{s|-O2|$(CFLAGS)|g}' \
		-e '/ -o /{s|-O2|$(CFLAGS) $(LDFLAGS)|g}' \
		-e '/strip/d' \
		|| die "sed Makefile.in failed"
}

src_configure() {
	tc-export CC
	# It's kind of weird. $(use_with postgres pgsql) won't work if you don't
	# use it...
	if use postgres ; then
		myconf="${myconf} --with-pgsql"
	fi

	econf ${myconf} || die "econf failed"
}

src_install() {
	dobin gld

	insinto /etc
	newins gld.conf gld.conf.example

	dodoc HISTORY README*

	insinto /usr/share/${PN}/sql
	doins *.pgsql *-whitelist.sql "${FILESDIR}"/tables.sql

	newinitd "${FILESDIR}"/gld.rc gld
}

pkg_postinst() {
	elog
	elog "Please read the README file in /usr/share/doc/${PF} for"
	elog "details on how to setup gld."
	elog
	elog "The sql files have been installed to /usr/share/${PN}/sql."
	elog
}
