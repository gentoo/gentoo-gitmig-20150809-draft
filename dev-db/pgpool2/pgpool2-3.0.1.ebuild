# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgpool2/pgpool2-3.0.1.ebuild,v 1.1 2011/01/26 16:49:09 scarabeus Exp $

EAPI=3

inherit autotools-utils

MY_P="${PN/2/-II}-${PV}"

DESCRIPTION="Connection pool server for PostgreSQL"
HOMEPAGE="http://pgpool.projects.postgresql.org/"
SRC_URI="http://pgfoundry.org/frs/download.php/2841/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pam ssl static-libs"

RDEPEND="
	dev-db/postgresql-base
	pam? ( sys-auth/pambase )
	ssl? ( dev-libs/openssl )
"
DEPEND="${DEPEND}
	sys-devel/bison"

AUTOTOOLS_IN_SOURCE_BUILD="1"

PATCHES=(
	"${FILESDIR}/${PN}-tmpdir.patch"
	"${FILESDIR}/${PV}-fix_md5_malloc.patch"
)

DOCS=(
	"NEWS"
	"doc/where_to_send_queries.pdf"
)
HTML_DOCS=(
	"doc/pgpool-en.html" "doc/pgpool.css"
	"doc/tutorial-en.html"
)

S=${WORKDIR}/${MY_P}

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

	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
}
