# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-1.1.1.ebuild,v 1.1 2006/03/20 08:04:01 nakano Exp $

inherit autotools eutils

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.refractions.net"
SRC_URI="http://www.postgis.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="geos proj"

DEPEND=">=dev-db/postgresql-7.2
	app-text/docbook-xsl-stylesheets
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )
	sys-devel/autoconf"
RDEPEND=">=dev-db/postgresql-7.2
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )"

src_unpack(){
	unpack "${P}.tar.gz"
	cd "${S}"
	# Remove redundant installation of README.postgis from docs-install
	epatch "${FILESDIR}"/${P}_doc.patch
}

src_compile(){
	local myconf

	cd "${S}"
	local xslv="$(portageq match / app-text/docbook-xsl-stylesheets |\
		cut -d'/' -f2 | sed s/"docbook-"//)"
	einfo "doc will be build with ${xslv}"
	if [ ! -z "$(echo ${xslv} | grep '\-r')" ]; then
		xslv="$(echo ${xslv} | cut -d'-' -f1 )-$(echo ${xslv} | cut -d'-' -f2 )-$(echo ${xslv} | cut -d'-' -f3)"
	fi
	sed s/"xsl-stylesheets"/"${xslv}"/ -i configure.in
	myconf="${myconf} --with-docdir=/usr/share/doc/${PF}/html/"

	eautoconf
	myconf="${myconf} --enable-autoconf \
		--libdir=/usr/$(get_libdir)/postgresql/\
		--datadir=/usr/share/postgresql/contrib/"
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
	cd ${S}
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

	# postgis_proc_upgrade.pl is not needed cause it was used during
	# the compilation process and create the file
	# /usr/share/postgresql/contrib/lwpostgis_upgrade.sql (used to upgrade all
	# functions defined into the new lwpostgis.sql, simply done with command :
	# 'create or replace function'). So I decided to install only
	# postgis_restore.pl for a hard upgrade (cf.
	# http://postgis.refractions.net/docs/ch02.html#upgrading)
	bininto "${D}"/usr/bin/
	dobin ./utils/postgis_restore.pl
}

pkg_postinst() {
	einfo "To create your first postgis database do the followings commands :"
	einfo " # su postgres"
	einfo " # createdb test"
	einfo " # createlang plpgsql test"
	einfo " # psql -d test -f /usr/share/postgresql/contrib/lwpostgis.sql"
	einfo " # psql -d test -f /usr/share/postgresql/contrib/spatial_ref_sys.sql"
	einfo "For more informations see : http://postgis.refractions.net/documentation.php"
	einfo "(For french user only see http://techer.pascal.free.fr/postgis)"
}
