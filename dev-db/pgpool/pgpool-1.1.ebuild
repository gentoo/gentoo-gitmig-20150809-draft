# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgpool/pgpool-1.1.ebuild,v 1.1 2004/05/01 12:16:44 nakano Exp $

DESCRIPTION="Connection pool server for PostgreSQL"
SRC_URI="ftp://ftp.sra.co.jp/pub/cmd/postgres/pgpool/${P}.tar.gz"
HOMEPAGE="http://www2b.biglobe.ne.jp/~caco/pgpool/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-db/postgresql"

src_compile() {
	econf --with-pgsql=/usr/include/postgresql || die
	emake || die
}

src_install () {
	einstall || die
	mv ${D}/etc/pgpool.conf.sample ${D}/etc/pgpool.conf
	dosed "s:/tmp:/var/run:g" /etc/pgpool.conf
	dosed "s:^logdir.*$:logdir = '/var/log':g" /etc/pgpool.conf
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}.init ${PN}
}

