# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-1.0.0_p20050512.ebuild,v 1.1 2005/05/24 21:18:52 nakano Exp $

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.refractions.net"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~nakano/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc geos proj"

RDEPEND=">=dev-db/postgresql-7.2
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )"
DEPEND="${RDEPEND}
	doc? ( app-text/docbook-xsl-stylesheets )
	sys-devel/autoconf"

S="${WORKDIR}/${PN}-cvs"
src_compile(){
	local myconf

	use ppc && CFLAGS="-pipe -fsigned-char"
	myconf="${myconf} --enable-autoconf --with-maxbackends=1024"

	cd ${S}
	if use doc; then
		local xslv=$(best_version app-text/docbook-xsl-stylesheets |\
			cut -d'/' -f2 | sed s/"docbook-"//)
		einfo "Building doc with ${xslv}"
		cat configure.in |\
			sed s/"xsl-stylesheets"/"${xslv}"/ > configure.in
	fi

	autoconf
	if use geos; then
		myconf="${myconf} $(use_with geos)=$(which geos-config)"
	fi
	if use proj; then
	    myconf="${myconf} $(use_with proj)=/usr"
	fi
	econf ${myconf} \
		|| die "Error: econf failed"
	if use doc; then
		einfo "doc will be built"
	else
		einfo "removing build directives for doc from Makefile"
		sed -e s/"utils docs"/"utils"/ \
			-e s/"loaderdumper-install docs-install"/"loaderdumper-install"/ \
				Makefile > Makefile.new
		mv Makefile.new Makefile
	fi

	emake || die "Error: emake failed"
}

src_install(){
	into /usr
	cd ${S}
	einstall || die "Error: einstall failed"
	dodir /usr/share/postgresql /usr/share/postgresql/contrib/
	mv ${D}/usr/share/*.sql ${D}/usr/share/postgresql/contrib/
	dodoc CHANGES COPYING CREDITS README.postgis TODO
	if use doc; then
		cd ${S}/doc
		dohtml -r html/*
		dodoc *.txt
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
