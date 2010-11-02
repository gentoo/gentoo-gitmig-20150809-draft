# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sphinx/sphinx-1.10_beta.ebuild,v 1.2 2010/11/02 18:13:16 grobian Exp $

EAPI=3
inherit eutils autotools

MY_P=${P/_/-}

# This has been added by Gentoo, to explicitly version libstemmer.
# It is the date that http://snowball.tartarus.org/dist/libstemmer_c.tgz was
# fetched.
STEMMER_PV="20091122"
DESCRIPTION="Full-text search engine with support for MySQL and PostgreSQL"
HOMEPAGE="http://www.sphinxsearch.com/"
SRC_URI="http://sphinxsearch.com/downloads/${MY_P}.tar.gz
	stemmer? ( mirror://gentoo/libstemmer_c-${STEMMER_PV}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug id64 mysql odbc postgres stemmer test"

RDEPEND="mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	odbc? ( dev-db/unixODBC )"
DEPEND="${RDEPEND}
	test? ( dev-lang/php )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	if use stemmer; then
		cd "${S}"
		unpack libstemmer_c-${STEMMER_PV}.tgz
	fi
}

src_prepare() {
	# drop nasty hardcoded search path breaking Prefix
	sed -i -e '/\/usr\/local\//d' configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}/etc/${PN}" \
		$(use_enable id64) \
		$(use_with debug) \
		$(use_with mysql) \
		$(use_with odbc unixodbc) \
		$(use_with postgres pgsql) \
		$(use_with stemmer libstemmer)
}

src_compile() {
	emake || die "emake failed"
}

src_test() {
	elog "Tests require access to a live MySQL database and may require configuration."
	elog "You will find them in /usr/share/${PN}/test and they require dev-lang/php"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc doc/*

	dodir /var/lib/sphinx
	dodir /var/log/sphinx
	dodir /var/run/sphinx

	newinitd "${FILESDIR}"/searchd.rc searchd

	if use test; then
		insinto /usr/share/${PN}
		doins -r test || die "install of test files failed."
	fi
}
