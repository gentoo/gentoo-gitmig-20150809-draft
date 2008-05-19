# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_spin/mod_spin-1.0.12.ebuild,v 1.5 2008/05/19 20:38:06 dev-zero Exp $

inherit apache-module autotools

DESCRIPTION="A simple template language, with persistent session data tracking and SQL connection pooling"
HOMEPAGE="http://rexursive.com/software/modspin"
SRC_URI="ftp://ftp.rexursive.com/pub/mod-spin/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres"

APACHE2_MOD_FILE="${S}/spin/.libs/${PN}.so"
APACHE2_MOD_CONF="80_${PN}"
APACHE2_MOD_DEFINE="SPIN"

DOCFILES="AUTHORS ChangeLog INSTALL NEWS README"

DEPEND=">=sys-libs/db-4.2
	dev-libs/libxml2
	www-apache/libapreq2
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )"

need_apache2

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:^docs/man/man3/rxv_spin_as_functions.3:# &:g' Makefile.am
	./buildconf
}

src_compile() {
	econf --with-apxs=${APXS} \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dolib spin/.libs/librxv_spin.so*
	apache-module_src_install
	doman docs/man/man3/*.3
	dohtml docs/html/*
}
