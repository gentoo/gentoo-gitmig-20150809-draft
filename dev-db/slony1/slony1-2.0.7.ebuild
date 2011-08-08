# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/slony1/slony1-2.0.7.ebuild,v 1.1 2011/08/08 09:38:04 titanofold Exp $

EAPI="4"

#inherit eutils

IUSE="doc perl"

DESCRIPTION="A replication system for the PostgreSQL Database Management System"
HOMEPAGE="http://slony.info/"

# ${P}-docs.tar.bz2 contains man pages as well as additional documentation
SRC_URI="http://main.slony.info/downloads/2.0/source/${P}.tar.bz2
		 http://main.slony.info/downloads/2.0/source/${P}-docs.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="|| (
			dev-db/postgresql-base:9.0[threads]
			dev-db/postgresql-base:8.4[threads]
			dev-db/postgresql-base:8.3[threads]
			dev-db/postgresql-base:9.1[threads]
		)
		|| (
			dev-db/postgresql-server:9.0
			dev-db/postgresql-server:8.4
			dev-db/postgresql-server:8.3
			dev-db/postgresql-server:9.1
		)
		perl? ( dev-perl/DBD-Pg )
"

pkg_setup() {
	local PGSLOT="$(postgresql-config show)"
	if [[ ${PGSLOT//.} < 83 ]] ; then
		eerror "You must build ${CATEGORY}/${PN} against PostgreSQL 8.3 or higher."
		eerror "Set an appropriate slot with postgresql-config."
		die "postgresql-config not set to 8.3 or higher."
	fi

	if [[ ${PGSLOT//.} > 90 ]] ; then
		ewarn "You are building ${CATEGORY}/${PN} against a version of PostgreSQL greater than 9.0."
		ewarn "This is neither supported here nor upstream."
		ewarn "Any bugs you encounter should be reported upstream."
	fi
}

src_configure() {
	econf $(use_with perl perltools)
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc HISTORY-1.1 INSTALL README SAMPLE TODO UPGRADING doc/howto/*.txt

	doman "${S}"/doc/adminguide/man{1,7}/*

	if use doc ; then
		cd "${S}"/doc
		dohtml -r *
	fi

	newinitd "${FILESDIR}"/slony1.init slony1
	newconfd "${FILESDIR}"/slony1.conf slony1
}
