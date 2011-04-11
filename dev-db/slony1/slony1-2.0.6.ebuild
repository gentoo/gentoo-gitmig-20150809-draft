# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/slony1/slony1-2.0.6.ebuild,v 1.1 2011/04/11 09:54:13 patrick Exp $

inherit eutils

IUSE="perl"

DESCRIPTION="A replication system for the PostgreSQL Database Management System"
HOMEPAGE="http://slony.info/"
SRC_URI="http://main.slony.info/downloads/2.0/source/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-db/postgresql-server
	perl? ( dev-perl/DBD-Pg )"

src_compile() {
	local myconf=""

	myconf="${myconf} --with-pgincludedir=/usr/include/postgresql/pgsql"
	myconf="${myconf} --with-pgincludeserverdir=/usr/include/postgresql/server"
	myconf="${myconf} $(use_with perl perltools)"

	econf ${myconf} || die "econf failed!"
	emake || die "emake failed!"

	if use perl ; then
		cd "${S}"/tools
		emake || die "emake tools failed!"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed!"

	dodoc HISTORY-1.1 INSTALL README SAMPLE TODO UPGRADING doc/howto/*.txt
	dohtml doc/howto/*.html

	newinitd "${FILESDIR}"/slony1.init slony1 || die "newinitd failed!"
	newconfd "${FILESDIR}"/slony1.conf slony1 || die "newconfd failed!"
}
