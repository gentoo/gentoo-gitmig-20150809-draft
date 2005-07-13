# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/slony1/slony1-1.1.0-r1.ebuild,v 1.1 2005/07/13 15:17:20 matsuu Exp $

inherit eutils

IUSE="perl"
#IUSE="perl snmp"

DESCRIPTION="A replication system for the PostgreSQL Database Management System"
HOMEPAGE="http://slony.info/"
SRC_URI="http://developer.postgresql.org/~wieck/slony1/download/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-db/postgresql
	perl? ( dev-perl/DBD-Pg )"
#	snmp? ( >=net-analyzer/net-snmp-5.1 )

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/slony1_remove_jave.patch
}

src_compile() {
	local myconf=""

	myconf="${myconf} --with-pgincludedir=/usr/include/postgresql/pgsql"
	myconf="${myconf} --with-pgincludeserverdir=/usr/include/postgresql/server"
	myconf="${myconf} $(use_with perl perltools)"
	# myconf="${myconf} $(use_with snmp netsnmp)"

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
