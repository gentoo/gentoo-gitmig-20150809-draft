# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/slony1/slony1-1.1.0_beta4.ebuild,v 1.1 2005/05/11 21:34:23 nakano Exp $

inherit eutils

IUSE=""

DESCRIPTION="A replication system for the PostgreSQL Database Management System"
HOMEPAGE="http://slony.info/"
MY_PV=${PV/_beta/.beta}
MY_P=${PN}-${MY_PV}
SRC_URI="http://developer.postgresql.org/~wieck/slony1/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-db/postgresql"

S=${WORKDIR}/${MY_P}
src_compile() {
	# temporary
	epatch ${FILESDIR}/slony1_remove_jave.patch

	econf --with-pgincludedir=/usr/include/postgresql/pgsql \
		--with-pgincludeserverdir=/usr/include/postgresql/server || die
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc README SAMPLE doc/howto/*.txt
	dohtml doc/howto/*.html

	exeinto /etc/init.d/
	newexe ${FILESDIR}/slony1.init slony1 || die

	insinto /etc/conf.d/
	newins ${FILESDIR}/slony1.conf slony1 || die
}
