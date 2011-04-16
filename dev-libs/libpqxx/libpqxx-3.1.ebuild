# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpqxx/libpqxx-3.1.ebuild,v 1.1 2011/04/16 11:00:47 titanofold Exp $

EAPI="4"

inherit eutils

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DESCRIPTION="C++ client API for PostgreSQL. The standard front-end for writing C++ programs that use PostgreSQL."
SRC_URI="http://pqxx.org/download/software/${PN}/${P}.tar.gz"
HOMEPAGE="http://pqxx.org/development/libpqxx/"
LICENSE="BSD"
SLOT="0"
IUSE="doc"

DEPEND="<dev-db/postgresql-base-9.0.0"
RDEPEND="${DEPEND}"

PROPERTIES="interactive"

src_configure() {
	econf --enable-shared
}

src_install () {
	emake DESTDIR="${D}" install

	dodoc AUTHORS ChangeLog NEWS README*
	use doc && dohtml -r doc/html/*
}

src_test() {
	ewarn "The tests need a running PostgreSQL server version 8.4.x or older"
	ewarn "and an existing database."
	ewarn "Make sure 'standard_conforming_strings' is set to off."

	echo -n "Database (Default: $(whoami)): "
	read PGDATABASE
	[[ -z $PGDATABASE ]] && PGDATABASE="$(whoami)"
	echo -n "Host (Default: Unix socket): "
	read PGHOST
	echo -n "Port (Default: 5432): "
	read PGPORT
	echo -n "User (Default: $(whoami)): "
	read PGUSER
	[[ -z $PGUSER ]] && PGUSER="$(whoami)"

	local server_version=$(psql -Aqwt -U ${PGUSER} -c 'SELECT version();' 2> /dev/null)
	if [[ $? = 0 ]] ; then
		server_version=$(echo ${server_version} | cut -d " " -f 2 | cut -d "." -f -2 | tr -d .)
		if [[ $server_version < 90 ]] ; then
			cd "${S}/test"
			PGDATABASE="$PGDATABASE" PGHOST="$PGHOST" PGPORT="$PGPORT" \
				PGUSER="$PGUSER" emake check
		else
			eerror "Server version must be 8.4.x are below."
			ewarn "Test will fail on versions greater than 8.4.x, so skipping."
		fi
	else
		eerror "Couldn't connect to server."
		ewarn "Is the server running?"
		ewarn "Check authentication method is set to trust for role: ${PGUSER}"
		ewarn "And database: ${PGDATABASE}"
		ewarn "Test will fail, so skipping."
	fi
}
