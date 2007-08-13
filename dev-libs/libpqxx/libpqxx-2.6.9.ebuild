# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpqxx/libpqxx-2.6.9.ebuild,v 1.5 2007/08/13 20:29:25 dertobi123 Exp $

inherit eutils

KEYWORDS="~alpha ~amd64 hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DESCRIPTION="C++ client API for PostgreSQL. The standard front-end for writing C++ programs that use PostgreSQL. Supersedes older libpq++ interface."
SRC_URI="ftp://pqxx.org/software/${PN}/${P}.tar.gz"
HOMEPAGE="http://pqxx.org/development/libpqxx/"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="dev-db/libpq"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# should be safe enough to remove the lines directly from configure,
	# since it's copied directly from configure.ac
	sed -i \
		-e 's/\(gcc_visibility\)=yes/\1=no/g' \
		-e 's@\(#define PQXX_HAVE_GCC_VISIBILITY 1\)@/* \1 */@g' \
		-e '/-Werror/d' \
		configure || die "sed failed"
}

src_compile() {
	econf --enable-shared || die "econf failed"
	emake || die "emake failed"
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
