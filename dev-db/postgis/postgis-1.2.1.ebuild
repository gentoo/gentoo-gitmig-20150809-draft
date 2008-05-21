# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-1.2.1.ebuild,v 1.2 2008/05/21 15:57:24 dev-zero Exp $

inherit autotools eutils versionator

KEYWORDS="~x86 ~ppc ~amd64"

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.refractions.net"
SRC_URI="http://www.postgis.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="geos proj doc"

RDEPEND=">=virtual/postgresql-server-7.4
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )"

DEPEND="${RDEPEND}
	doc? ( app-text/docbook-xsl-stylesheets )"

RESTRICT="test"

pkg_setup(){
	local tmp
	tmp="$(portageq match / postgis | cut -d'.' -f2)"
	if [ "${tmp}" != "$(get_version_component_range 2)" ]; then
		elog "You must soft upgrade your existing postgis enabled databases"
		elog "using 'emerge --config postgis'."
		require_soft_upgrade="1"
		ebeep 2
	fi
}

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}_xsl.patch"

	eautoconf
}

src_compile(){
	local myconf
	if use geos; then
		myconf="--with-geos"
	fi

	if use doc;then
		myconf="${myconf} --with-xsl=$(ls "${ROOT}"usr/share/sgml/docbook/* | \
			grep xsl\- | cut -d':' -f1)"
	fi

	econf --enable-autoconf \
		--datadir=/usr/share/postgresql/contrib/ \
		--libdir=/usr/$(get_libdir)/postgresql/ \
		--with-docdir=/usr/share/doc/${PF}/html/ \
		${myconf} \
		$(use_with proj) ||\
			die "Error: econf failed"

	emake || die "Error: emake failed"

	cd topology/
	emake || die "Unable to build topology sql file"

	if use doc ; then
		cd "${S}"
		emake docs || die "Unable to build documentation"
	fi
}

src_install(){
	dodir /usr/$(get_libdir)/postgresql /usr/share/postgresql/contrib/
	emake DESTDIR="${D}" install || die "emake install failed"
	cd "${S}/topology/"
	emake DESTDIR="${D}" install || die "emake install topology failed"

	cd "${S}"
	dodoc Changelog CREDITS TODO loader/README.* doc/*txt

	docinto topology
	dodoc topology/{TODO,README}
	dobin ./utils/postgis_restore.pl

	cd "${S}"
	if use doc; then
		emake DESTDIR="${D}" docs-install || die "emake install docs failed"
	fi

	if [ ! -z "${require_soft_upgrade}" ]; then
		grep "'C'" -B 4 "${D}"usr/share/postgresql/contrib/lwpostgis.sql |\
			grep -v "'sql'" > \
				"${D}"usr/share/postgresql/contrib/load_before_upgrade.sql
	fi
}

pkg_postinst() {
	elog "To create new spatial database use 'emerge --config ${PN}.'"
}

pkg_config(){
	PGUSER="${PGUSER:-postgres}"
	PGDATABASE="${PGDATABASE:-template_postgis}"

	is_template=false
	if [ "${PGDATABASE:0:8}" == "template" ];then
		is_template=true
		mytype="template database"
	else
		mytype="database"
	fi

	einfo "Create or upgrade a spatial template and database."
	einfo "Using the user ${PGUSER} and the ${PGDATABASE} ${mytype}."
	einfo "Please do 'export PGUSER=...' to use another user."
	einfo "Please do 'export PGDATABASE=...' to set another template/database"
	einfo "name (templates name have to be prefixed with 'template')."

	logfile=$(mktemp "${ROOT}tmp/error.log.XXXXXX")
	safe_exit(){
		eerror "Removing created ${mydb} ${mytype}"
		dropdb -q || (eerror "${1}"
			die "Removing old db failed, you must do it manually")
		eerror "Please see ${logfile} for more information."
		die "${1}"
	}

	# if there is not a table or a template existing with the same name, create.
	psql -ql 2> ${logfile}
	if [ "$?" == 2 ];then
		die "Unable to access databases server using the ${PGUSER} user"
	fi
	PGDBS="$(psql template1 -Atc \
		'select 1 from pg_tables where tablename=${PGDATABASE};')"
	if [ "$(psql -l | grep "${PGDATABASE}")" != 1 ]; then
		einfo
		einfo "Please hit ENTER if you want to create the ${PGDATABASE}"
		einfo "${mytype} as "${PGUSER}" user, or Control-C to abort now..."
		read
		einfo "Creating the ${mytype} ${PGDATABASE}."
		createdb -q -O ${PGUSER} ||\
			die "Unable to create the ${mydb} ${mytype} as ${myuser}"
		createlang plpgsql
		if [ "$?" == 2 ]; then
				safe_exit "${myuser} not allowed to createlang plpgsql ${mydb}."
		fi
		einfo "Loading PostGIS files into ${PGDATABASE}."
		(psql -q -f \
			"${ROOT}"usr/share/postgresql/contrib/lwpostgis.sql &&
		psql -q -f \
			"${ROOT}"usr/share/postgresql/contrib/spatial_ref_sys.sql) 2>\
				"${logfile}"
		if [ "$(grep -c ERROR "${logfile}")" \> 0 ]; then
				safe_exit "Unable to load the sql files."
		fi
		if ${is_template}; then
			einfo "Configure ${PGDATABASE} as a ${mytype}"
			psql -q  -c \
				"UPDATE pg_database SET datistemplate=TRUE, datallowconn=FALSE
				WHERE datname = '${PGDATABASE}';
				VACUUM FREEZE;" || die "Unable to create ${mydb}"
		fi
	else
		einfo
		einfo "Please hit ENTER if you want to upgrade the ${mydb}"
		einfo "${mytype} as ${myuser} user, or Control-C to abort now..."
		read
		if [ -e "${ROOT}"usr/share/postgresql/contrib/load_before_upgrade.sql ];
		then
			einfo "Updating the dynamic library references"
			psql -q -f \
				"${ROOT}"usr/share/postgresql/contrib/load_before_upgrade.sql\
					2> "${logfile}"
			if [ "$(grep -c ERROR "${logfile}")" \> 0 ]; then
				safe_exit "Unable to update references."
			fi
		fi
		if [ -e "${ROOT}"usr/share/postgresql/contrib/lwpostgis_upgrade.sql ];
		then
			einfo "Running soft upgrade"
			psql -q -f \
				"${ROOT}"usr/share/postgresql/contrib/lwpostgis_upgrade.sql 2>\
					"${logfile}"
			if [ "$(grep -c ERROR "${logfile}")" \> 0 ]; then
				safe_exit "Unable to run soft upgrade."
			fi
		fi
	fi

	if ${is_template}; then
		einfo "You can now create a spatial database using :"
		einfo "createdb -T ${PGDATABASE} <db_name>"
	fi
}
