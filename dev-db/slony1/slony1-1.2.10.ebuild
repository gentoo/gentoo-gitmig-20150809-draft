# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/slony1/slony1-1.2.10.ebuild,v 1.4 2007/08/15 09:10:32 jokey Exp $

inherit eutils

IUSE="perl"

DESCRIPTION="A replication system for the PostgreSQL Database Management System"
HOMEPAGE="http://slony.info/"
SRC_URI="http://main.slony.info/downloads/1.2/source/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND="dev-db/postgresql
	perl? ( dev-perl/DBD-Pg )"

src_compile() {
	local myconf=""

	myconf="${myconf} --with-pgincludedir=/usr/include/postgresql/pgsql"
	myconf="${myconf} --with-pgincludeserverdir=/usr/include/postgresql/server"
	myconf="${myconf} $(use_with perl perltools)"

	econf ${myconf} || die
	emake || die

	if use perl ; then
		cd ${S}/tools
		emake || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc HISTORY-1.1 INSTALL README SAMPLE TODO UPGRADING doc/howto/*.txt
	dohtml doc/howto/*.html

	newinitd ${FILESDIR}/slony1.init slony1 || die
	newconfd ${FILESDIR}/slony1.conf slony1 || die

}
