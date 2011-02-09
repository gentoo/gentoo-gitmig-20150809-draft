# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgpool2/pgpool2-9999.ebuild,v 1.1 2011/02/09 08:18:38 scarabeus Exp $

EAPI=4

ECVS_SERVER="cvs.pgfoundry.org:/cvsroot/pgpool"
ECVS_MODULE="pgpool-II"
inherit autotools-utils cvs autotools

DESCRIPTION="Connection pool server for PostgreSQL"
HOMEPAGE="http://pgpool.projects.postgresql.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="pam ssl static-libs"

RDEPEND="
	dev-db/postgresql-base
	pam? ( sys-auth/pambase )
	ssl? ( dev-libs/openssl )
"
DEPEND="${DEPEND}
	sys-devel/bison"

AUTOTOOLS_IN_SOURCE_BUILD="1"

DOCS=(
	"NEWS"
	"doc/where_to_send_queries.pdf"
)
HTML_DOCS=(
	"doc/pgpool-en.html" "doc/pgpool.css"
	"doc/tutorial-en.html"
)

S="${WORKDIR}/pgpool-II/"

src_prepare() {
	sed -i \
		-e 's:/tmp/:/var/run/postgresql:g' \
		pgpool.conf.sample pool.h || die
	sed -i \
		-e '/ACLOCAL_AMFLAGS/ d' \
		Makefile.am || die
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		"--sysconfdir=${EROOT}/etc/${PN}"
		"--disable-dependency-tracking"
		"--disable-rpath"
		$(use_with ssl openssl)
		$(use_with pam)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	remove_libtool_files all
	# move misc data to proper folder
	mv "${ED}/usr/share/${PN/2/-II}" "${ED}/usr/share/${PN}" || die

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
}
