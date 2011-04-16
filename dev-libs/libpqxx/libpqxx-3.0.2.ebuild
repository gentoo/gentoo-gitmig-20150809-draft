# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpqxx/libpqxx-3.0.2.ebuild,v 1.4 2011/04/16 11:00:47 titanofold Exp $

EAPI="2"

inherit eutils

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DESCRIPTION="C++ client API for PostgreSQL. The standard front-end for writing C++ programs that use PostgreSQL."
SRC_URI="http://pqxx.org/download/software/${PN}/${P}.tar.gz"
HOMEPAGE="http://pqxx.org/development/libpqxx/"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="dev-db/postgresql-base"
RDEPEND="${DEPEND}"

src_prepare() {
	# should be safe enough to remove the lines directly from configure,
	# since it's copied directly from configure.ac
	sed -i \
		-e 's/\(gcc_visibility\)=yes/\1=no/g' \
		-e 's@\(#define PQXX_HAVE_GCC_VISIBILITY 1\)@/* \1 */@g' \
		-e '/-Werror/d' \
		configure || die "sed failed"
}

src_configure() {
	econf --enable-shared || die "econf failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README* TODO
	dohtml -r doc/html/*
}

src_test() {
	ewarn "The tests need a running PostgreSQL server and an existing database!"
	ewarn "You can set the following environment variables to change the connection parameters:"
	ewarn "PGDATABASE (default: username, probably root)"
	ewarn "PGHOST (default: localhost)"
	ewarn "PGPORT (default: pg's UNIX domain-socket)"
	ewarn "PGUSER (default: username, probably root)"
	epause 10

	if [[ -n ${PGDATABASE} ]] ; then
		cd "${S}/test"
		# Working around a mysterious bug in gcc-4.1
		sed -i -e 's/-O2/-O1/' Makefile
		emake -j1 check || die "emake check failed"
	else
		ewarn "Tests skipped since PGDATABASE is not defined or empty"
	fi
}
