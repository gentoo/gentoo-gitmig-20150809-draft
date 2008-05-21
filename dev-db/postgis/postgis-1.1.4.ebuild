# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-1.1.4.ebuild,v 1.5 2008/05/21 15:57:24 dev-zero Exp $

inherit autotools eutils

KEYWORDS="~amd64 ppc x86"

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.refractions.net"
SRC_URI="http://www.postgis.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="geos proj"

DEPEND=">=virtual/postgresql-server-7.4
		app-text/docbook-xsl-stylesheets
		geos? ( sci-libs/geos )
		proj? ( sci-libs/proj )
		sys-devel/autoconf"
RDEPEND=">=virtual/postgresql-server-7.4
		geos? ( sci-libs/geos )
		proj? ( sci-libs/proj )"

RESTRICT="test"

pkg_setup(){
	tmp="$(portageq match / ${CATEGORY}/${PN})"
	if [ "${tmp}" != "${CATEGORY}/${PF}" ]; then
		ewarn "Don't forget to dump your databases with -Fc options before"
		ewarn "upgrading postgis."
		ewarn "(see http://postgis.refractions.net/docs/ch02.html#upgrading)"
		ebeep 4
	fi
}

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.1.1_doc.patch"

	local xslv
	xslv="$(ls /usr/share/sgml/docbook/ | grep xsl\-)"
	einfo "doc will be build with template :"
	einfo "${xslv}"
	sed "s:xsl-stylesheets:${xslv}:" -i configure.in || die "xsl-stylesheets pb"

	eautoconf
}

src_compile(){
	cd "${S}"

	econf \
		--enable-autoconf \
		--datadir=/usr/share/postgresql/contrib/ \
		--libdir=/usr/$(get_libdir)/postgresql/ \
		--with-docdir=/usr/share/doc/${PF}/html/ \
		$(use_with geos) \
		$(use_with proj)\
		|| die "Error: econf failed"

	emake || die "Error: emake failed"

	emake docs || die "Unable to build documentation"
	cd topology/
	emake || die "Unable to build topology sql file"
}

src_install(){
	cd "${S}"
	dodir /usr/$(get_libdir)/postgresql /usr/share/postgresql/contrib/
	emake DESTDIR="${D}" install || die "emake install failed"
	cd "${S}/topology/"
	emake DESTDIR="${D}" install || die "emake install topology failed"

	cd "${S}"
	dodoc CHANGES CREDITS README.postgis TODO loader/README.* \
		doc/*txt

	docinto topology
	dodoc topology/{TODO,README}

	cd "${S}"
	emake DESTDIR="${D}" docs-install || die "emake install docs failed"

	dobin ./utils/postgis_restore.pl
}

pkg_postinst() {
	einfo "To create your first postgis database use the following commands :"
	einfo " # su postgres"
	einfo " # createdb test"
	einfo " # createlang plpgsql test"
	einfo " # psql -d test -f /usr/share/postgresql/contrib/lwpostgis.sql"
	einfo " # psql -d test -f /usr/share/postgresql/contrib/spatial_ref_sys.sql"
	einfo "For more informations see : http://www.postgis.org/documentation.php"
	einfo "(For french user only see http://postgis.fr)"
}
