# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgmecab/pgmecab-1.1.ebuild,v 1.2 2008/05/21 15:56:55 dev-zero Exp $

DESCRIPTION="PostgreSQL function to Wakachigaki for Japanese words"
HOMEPAGE="http://www.emaki.minidns.net/Programming/postgres/index.html"
SRC_URI="http://www.emaki.minidns.net/Programming/postgres/${P}.tar.bz2"

DEPEND="app-text/mecab
	>=virtual/postgresql-server-7.4"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack () {
	unpack ${A}
	cd ${S}
	sed -i -e 's:^MECAB_CONFIG_PATH.*$:MECAB_CONFIG_PATH=/usr/bin/mecab-config:' Makefile
}

src_compile() {
	make USE_PGXS=1
}

src_install() {
	make DESTDIR=${D} USE_PGXS=1 install
}
