# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-1.3.3.ebuild,v 1.2 2008/05/06 17:41:19 djay Exp $

inherit autotools eutils versionator

KEYWORDS="~amd64 ~ppc ~x86"

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.refractions.net"
SRC_URI="http://www.postgis.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="geos proj doc"

RDEPEND=">=dev-db/postgresql-7.4
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
	myuser="${PG_USER:-postgres}"
	mydb="${PGDATABASE:-template_gis}"

	is_template=false
	if [ "${mydb:0:8}" == "template" ];then
		is_template=true
		mytype="template database"
	else
		mytype="database"
	fi

	einfo "Create or upgrade a spatial template and database."
	einfo "Using the user ${myuser} and the ${mydb} ${mytype}."
	einfo "Please do 'export PG_USER=...' to use another user."
	einfo "Please do 'export PGDATABASE=...' to set another template/database"
	einfo "name (templates name have to be prefixed with 'template')."

	logfile=$(mktemp "${ROOT}tmp/error.log.XXXXXX")
	safe_exit(){
		eerror "Removing created ${mydb} ${mytype}"
		dropdb -q -U "${myuser}" "${mydb}" ||\
			(eerror "${1}"
			die "Removing old db failed, you must do it manually")
		eerror "Please read ${logfile} for more information."
		die "${1}"
	}

	# if there is not a table or a template existing with the same name, create.
	if [ -z "$(psql -U "${myuser}" -l | grep "${mydb}")" ]; then
		einfo
		einfo "Please hit ENTER if you want to create the ${mydb}"
		einfo "${mytype} as "${myuser}" user, or Control-C to abort now..."
		read
		createdb -q -O ${myuser} -U ${myuser} ${mydb} ||\
			die "Unable to create the ${mydb} ${mytype} as ${myuser}"
		createlang -U ${myuser} plpgsql ${mydb}
		if [ "$?" == 2 ]; then
				safe_exit "Unable to createlang plpgsql ${mydb}."
		fi
		(psql -q -U ${myuser} ${mydb} -f \
			"${ROOT}"usr/share/postgresql/contrib/lwpostgis.sql &&
		psql -q -U ${myuser} ${mydb} -f \
			"${ROOT}"usr/share/postgresql/contrib/spatial_ref_sys.sql) 2>\
				"${logfile}"
		if [ "$(grep -c ERROR "${logfile}")" \> 0 ]; then
				safe_exit "Unable to load sql files."
		fi
		if ${is_template}; then
			psql -q -U ${myuser} ${mydb} -c \
				"UPDATE pg_database SET datistemplate = TRUE
				WHERE datname = '${mydb}';
				GRANT ALL ON table spatial_ref_sys, geometry_columns TO PUBLIC;
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
			psql -q -U ${myuser} ${mydb} -f \
				"${ROOT}"usr/share/postgresql/contrib/load_before_upgrade.sql\
					2> "${logfile}"
			if [ "$(grep -c ERROR "${logfile}")" \> 0 ]; then
				safe_exit "Unable to update references."
			fi
		fi
		if [ -e "${ROOT}"usr/share/postgresql/contrib/lwpostgis_upgrade.sql ];
		then
			einfo "Running soft upgrade"
			psql -q -U ${myuser} ${mydb} -f \
				"${ROOT}"usr/share/postgresql/contrib/lwpostgis_upgrade.sql 2>\
					"${logfile}"
			if [ "$(grep -c ERROR "${logfile}")" \> 0 ]; then
				safe_exit "Unable to run soft upgrade."
			fi
		fi
	fi

	if ${is_template}; then
		einfo "You can now create a spatial database using :"
		einfo "'createdb -T ${mydb} test'"
	fi
}
