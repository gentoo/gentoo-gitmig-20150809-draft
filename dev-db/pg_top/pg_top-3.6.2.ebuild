# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pg_top/pg_top-3.6.2.ebuild,v 1.5 2010/06/17 18:41:06 patrick Exp $

inherit eutils autotools

DESCRIPTION="'top' for PostgreSQL"
HOMEPAGE="http://ptop.projects.postgresql.org/"
SRC_URI="http://pgfoundry.org/frs/download.php/1780/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

COMMON_DEPEND="dev-db/postgresql-base"
DEPEND="$COMMON_DEPEND
	dev-util/pkgconfig"
RDEPEND="$COMMON_DEPEND"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}.patch"
	eautoreconf
}

src_compile() {
	econf $(use_enable debug)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc FAQ HISTORY README TODO Y2K
}
