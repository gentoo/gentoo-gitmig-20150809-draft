# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgmecab/pgmecab-1.1-r3.ebuild,v 1.2 2008/11/16 06:29:43 matsuu Exp $

inherit eutils versionator

DESCRIPTION="PostgreSQL function to Wakachigaki for Japanese words"
HOMEPAGE="http://www.emaki.minidns.net/Programming/postgres/index.html"
SRC_URI="http://www.emaki.minidns.net/Programming/postgres/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/mecab
	>=dev-db/postgresql-server-7.4" # pgmecab requires PGXS
DEPEND="${RDEPEND}
	app-admin/eselect-postgresql"

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"

	# Bug #239594
	PGVER=( $(get_version_components $(eselect postgresql show)) )
	PGMAJOR="${PGVER[0]}"
	PGMINOR="${PGVER[1]}"
	if [ ${PGMAJOR} -eq 8 -a ${PGMINOR} -gt 2 -o ${PGMAJOR} -gt 8 ] ; then
		epatch "${FILESDIR}/${PF}-postgres83.patch"
	fi
}

src_compile() {
	emake USE_PGXS=1 || die
}

src_install() {
	emake DESTDIR="${D}" USE_PGXS=1 install || die

	dodoc README.pgmecab
}
