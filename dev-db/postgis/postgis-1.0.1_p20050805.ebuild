# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-1.0.1_p20050805.ebuild,v 1.2 2005/08/28 20:05:09 swegener Exp $

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.refractions.net"
SRC_URI="http://gentoo.01map.net/distfiles/${PN}-cvs-${PV}.tar.gz"

S="${WORKDIR}/${PN}-cvs"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc geos proj"

DEPEND=">=dev-db/postgresql-8.0.0
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )
	doc? ( app-text/docbook-xsl-stylesheets )
	sys-devel/autoconf"
RDEPEND=">=dev-db/postgresql-8.0.0
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )"

src_compile(){
	local myconf

	use ppc && CFLAGS="-pipe -fsigned-char"

	myconf="${myconf} --enable-autoconf --with-maxbackends=1024"

	if use doc; then
		local xslv="$(portageq match / app-text/docbook-xsl-stylesheets |\
			cut -d'/' -f2 | sed s/"docbook-"//)"
		einfo "Building doc with ${xslv}"
		if [ ! -z "$(echo ${xslv} | grep '\-r')" ]; then
			xslv="$(echo ${xslv} | cut -d'-' -f1 )-$(echo ${xslv} | cut -d'-' -f2 )-$(echo ${xslv} | cut -d'-' -f3)"
		fi
		sed s/"xsl-stylesheets"/"${xslv}"/ -i configure.in
	fi

	autoconf

	if use geos; then
		myconf="${myconf} $(use_with geos)=$(which geos-config)"
	fi
	if use proj; then
	    myconf="${myconf} $(use_with proj)=/usr"
	fi
	if use doc; then
		einfo "doc will be build"
		myconf="${myconf} --with-docdir=${D}/usr/share/doc/${PF}/html/"
	else
		einfo "doc will not be build"
	fi

	econf ${myconf} --mandir=${D}/usr/share/man \
		|| die "Error: econf failed"

	emake || die "Error: emake failed"

	if use doc; then
		make docs
	fi
}

src_install(){
	dodir /usr/libexec /usr/share/postgresql /usr/share/postgresql/contrib/
	einstall || die "Error: einstall failed"
	mv ${D}/usr/share/*.sql ${D}/usr/share/postgresql/contrib/
	dodoc CHANGES COPYING CREDITS README.postgis TODO
	if use doc; then
		cd ${S}
		make docs-install
		rm ${D}/usr/share/doc/${PF}/html/postgis/README.postgis
	fi
}

pkg_postinst() {
	einfo "To create your first postgis database do the followings commands :"
	einfo " # su postgres"
	einfo " # createdb -E SQL_ASCII poolp"
	einfo " # createlang plpgsql poolp"
	einfo " # psql -d poolp -f /usr/share/postgresql/contrib/lwpostgis.sql"
	einfo " # psql -d poolp -f /usr/share/postgresql/contrib/spatial_ref_sys.sql"
	einfo "For more informations go to : http://postgis.refractions.net/documentation.php"
	einfo "(For french user only see http://techer.pascal.free.fr/postgis)"
}
