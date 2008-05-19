# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgpool/pgpool-2.6.3.ebuild,v 1.6 2008/05/19 19:12:55 dev-zero Exp $

DESCRIPTION="Connection pool server for PostgreSQL"
HOMEPAGE="http://pgpool.projects.postgresql.org/"
SRC_URI="http://pgfoundry.org/frs/download.php/426/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="virtual/postgresql-base"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "/^logdir/s:/tmp:/var/run:g" pgpool.conf.sample || die
}

src_compile() {
	econf --with-pgsql=/usr/include/postgresql || die
	emake || die
}

src_install () {
	einstall || die
	mv ${D}/etc/pgpool.conf.sample ${D}/etc/pgpool.conf
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO
	newinitd ${FILESDIR}/${PN}.init ${PN}
}
