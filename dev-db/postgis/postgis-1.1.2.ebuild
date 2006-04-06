# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-1.1.2.ebuild,v 1.1 2006/04/06 20:27:57 djay Exp $

inherit autotools eutils

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.refractions.net"
SRC_URI="http://www.postgis.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="geos proj"

DEPEND=">=dev-db/postgresql-7.4
	app-text/docbook-xsl-stylesheets
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )
	sys-devel/autoconf"
RDEPEND=">=dev-db/postgresql-7.4
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
	unpack "${P}.tar.gz"
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.1.1_doc.patch
	local xslv
	xslv="$(ls /usr/share/sgml/docbook/ | grep xsl\-)"
	einfo "doc will be build with template :"
	einfo "${xslv}"
	sed "s:xsl-stylesheets:${xslv}:" -i configure.in || die "xsl-stylesheets pb"
}

src_compile(){
	cd "${S}"
	eautoconf
	local myconf
	myconf="${myconf} --enable-autoconf \
		--datadir=/usr/share/postgresql/contrib/\
		--libdir=/usr/$(get_libdir)/postgresql/\
		--with-docdir=/usr/share/doc/${PF}/html/"
	econf ${myconf} \
		$(use_with geos) \
		$(use_with proj)\
		|| die "Error: econf failed"

	emake || die "Error: emake failed"

	make docs || die "Unable to build documentation"
	cd topology/
	emake || die "Unable to build topology sql file"
}

src_install(){
	into /usr
	cd "${S}"
	dodir /usr/$(get_libdir)/postgresql /usr/share/postgresql/contrib/
	make DESTDIR="${D}" install || die "einstall failed"
	cd "${S}"/topology/
	make DESTDIR="${D}" install

	cd "${S}"
	dodoc CHANGES COPYING CREDITS README.postgis TODO loader/README.*\
		doc/*txt || die "Unable to install doc"

	docinto topology
	dodoc topology/{TODO,README}

	cd "${S}"
	make DESTDIR="${D}" docs-install || die "Unable to install documentation"

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
