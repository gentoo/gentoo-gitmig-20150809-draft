# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgpool2/pgpool2-9999.ebuild,v 1.3 2011/06/19 18:50:43 scarabeus Exp $

EAPI=4

[[ ${PV} == 9999 ]] && MY_P=${PN/2/-II} || MY_P="${PN/2/-II}-${PV}"

ECVS_SERVER="cvs.pgfoundry.org:/cvsroot/pgpool"
ECVS_MODULE="pgpool-II"
[[ ${PV} == 9999 ]] && SCM_ECLASS="cvs"
inherit base autotools ${SCM_ECLASS}
unset SCM_ECLASS

DESCRIPTION="Connection pool server for PostgreSQL"
HOMEPAGE="http://pgpool.projects.postgresql.org/"
[[ ${PV} == 9999 ]] || SRC_URI="http://pgfoundry.org/frs/download.php/3076/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~x86"
IUSE="pam ssl static-libs"

RDEPEND="
	dev-db/postgresql-base
	pam? ( sys-auth/pambase )
	ssl? ( dev-libs/openssl )
"
DEPEND="${DEPEND}
	sys-devel/bison
	!!dev-db/pgpool
"

AUTOTOOLS_IN_SOURCE_BUILD="1"

DOCS=(
	"NEWS"
	"doc/where_to_send_queries.pdf"
)
HTML_DOCS=(
	"doc/pgpool-en.html"
	"doc/pgpool.css"
	"doc/tutorial-en.html"
)

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e 's:/tmp/:/var/run/postgresql:g' \
		pgpool.conf.sample pool.h || die
	sed -i \
		-e '/ACLOCAL_AMFLAGS/ d' \
		Makefile.am || die
	base_src_prepare
	eautoreconf
}

src_configure() {
	econf \
		--sysconfdir=${EROOT}/etc/${PN} \
		--disable-rpath \
		$(use_enable static-libs static) \
		$(use_with ssl openssl) \
		$(use_with pam)
}

src_install() {
	base_src_install
	find "${ED}" -name '*.la' -exec rm -f {} +
	# move misc data to proper folder
	mv "${ED}/usr/share/${PN/2/-II}" "${ED}/usr/share/${PN}" || die

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
}
