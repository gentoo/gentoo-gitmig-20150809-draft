# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/slony1/slony1-1.1.0.ebuild,v 1.2 2005/06/29 16:09:52 nakano Exp $

inherit eutils

IUSE=""

MY_P=${P/_/.}
DESCRIPTION="A replication system for the PostgreSQL Database Management System"
HOMEPAGE="http://slony.info/"
SRC_URI="http://developer.postgresql.org/~wieck/slony1/download/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-db/postgresql"

S=${WORKDIR}/${P/_/-}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/slony1_remove_jave.patch
}

src_compile() {
	econf --with-pgincludedir=/usr/include/postgresql/pgsql \
		--with-pgincludeserverdir=/usr/include/postgresql/server || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc HISTORY-1.1 INSTALL README SAMPLE TODO UPGRADING doc/howto/*.txt
	dohtml doc/howto/*.html

	newinitd ${FILESDIR}/slony1.init slony1 || die

	insinto /etc/conf.d/
	newconfd ${FILESDIR}/slony1.conf slony1 || die
}
