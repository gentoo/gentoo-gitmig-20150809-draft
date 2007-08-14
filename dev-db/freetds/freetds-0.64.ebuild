# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freetds/freetds-0.64.ebuild,v 1.8 2007/08/14 10:53:54 hkbst Exp $

KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
DESCRIPTION="Tabular Datastream Library."
HOMEPAGE="http://www.freetds.org/"
SRC_URI="http://ibiblio.org/pub/Linux/ALPHA/freetds/stable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="odbc mssql"

DEPEND="odbc? ( dev-db/unixODBC )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf
	use odbc && myconf="--with-unixodbc=/usr"
	use mssql && myconf="${myconf} --enable-msdblib"
	econf --with-tdsver=7.0 ${myconf} --cache-file="${S}/config.cache" || die "econf failed"
	emake || die "emake failed"
}

RESTRICT="test"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
