# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgpool/pgpool-0.1.6.ebuild,v 1.1 2003/12/25 04:49:37 nakano Exp $

DESCRIPTION="Connection pool server for PostgreSQL"
SRC_URI="ftp://ftp.sra.co.jp/pub/cmd/postgres/pgpool/${P}.tar.gz"
HOMEPAGE=""
LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-db/postgresql"

S="${WORKDIR}/${P}"

src_compile() {
	econf --with-pgsql=/usr/include/postgresql || die
	emake || die
}

src_install () {
	einstall || die
	mv ${D}/etc/pgpool.conf.sample ${D}/etc/pgpool.conf
	dosed "s:/tmp:/var/run:g" /etc/pgpool.conf
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}.init ${PN}
}
