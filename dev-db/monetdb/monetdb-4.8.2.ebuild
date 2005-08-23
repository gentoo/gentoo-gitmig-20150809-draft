# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/monetdb/monetdb-4.8.2.ebuild,v 1.2 2005/08/23 14:33:36 swegener Exp $

inherit flag-o-matic eutils

DESCRIPTION="A main-memory relational database for SQL, XQuery and MIL"
HOMEPAGE="http://monetdb.cwi.nl/"
PV_SQL=2.8.2
PV_XQ=0.8.2
SRC_URI="mirror://sourceforge/monetdb/MonetDB-${PV}.tar.gz
		mirror://sourceforge/monetdb/MonetDB-SQL-${PV_SQL}.tar.gz
		mirror://sourceforge/monetdb/MonetDB-XQuery-${PV_XQ}.tar.gz
		ppc-macos? ( mirror://gentoo/monetdb-pathfinder-bison-sources-0.8.2.tar.bz2 )"
LICENSE="MonetDBPL-1.1 PathfinderPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc-macos"
IUSE="java readline"

DEPEND="virtual/libc
		sys-devel/flex
		ppc-macos? ( sys-devel/bison )
		!ppc-macos? ( >=sys-devel/bison-1.33 )
		>=sys-devel/gcc-3.3
		java? ( >=virtual/jdk-1.4 )
		readline? ( >=sys-libs/readline-4.1 )
		dev-libs/libxml2"

DATA_DIR="/var/lib/MonetDB"

pkg_setup() {
	if [ -x ${DATA_DIR}/dbfarm ] || [ -x ${DATA_DIR}/log ]; then
		while read line; do eerror "${line}"; done <<EOF
MonetDB ${MY_PV} cannot upgrade your existing SQL databases.  You must
export your existing SQL databases to a file using "JdbcClient -D" and
then restore them when you have upgraded completey using
"JdbcClient -f".

If you have MIL BATs, aging from before MonetDB 4.8.0 your have to
convert those after upgrading.  See the following for more information
on upgrading from previous database versions:
http://monetdb.cwi.nl/TechDocs/FrontEnds/SQL/upgrade/
http://monetdb.cwi.nl/TechDocs/FrontEnds/mil/upgrade/

You must remove your entire database directory to continue.
(database directory = ${DATA_DIR}).
EOF
		die "Cannot upgrade automatically."
	fi

	enewgroup monetdb
	enewuser monetdb -1 /bin/bash ${DATA_DIR} monetdb
}

src_unpack() {
	unpack ${A} || die

	epatch ${FILESDIR}/monetdb-${PV}-gentoo-conf.patch
	epatch ${FILESDIR}/monetdb-${PV}-gentoo-MapiClient.patch
}

src_compile() {
	# The tar has capitals, the ebuild doesn't...
	cd ${WORKDIR}/MonetDB-${PV}

	econf \
		"--enable-optimize" \
		$(use_with java) \
		$(use_with readline) \
		|| die "econf monetdb failed"

	emake || die "emake monetdb failed"

	# make the header files available to the sql and xquery compilation
	mkdir include
	cd include
	ln -s ../src/common
	ln -s ../src/gdk
	ln -s ../src/monet
	ln -s ../src/modules/plain
	ln -s ../src/modules/contrib
	ln -s ../src/mapi
	ln -s ../src/mapi/clients/C
	ln -s ../monetdb_config.h
	ln -s ../sysdefs.h

	cd ${WORKDIR}/MonetDB-${PV}
	mkdir -p lib/MonetDB
	cd lib/MonetDB
	find ../.. -name "lib_*" -exec ln -s {} ';' >& /dev/null
	ln -s . .libs

	cd ${WORKDIR}/MonetDB-${PV}/lib
	find .. -name "lib*" -exec ln -s {} ';' >& /dev/null
	ln -s . .libs

	cd ${WORKDIR}/MonetDB-${PV}
	mkdir bin
	cd bin
	ln -s ../src/mel/mel
	ln -s ../src/utils/Mx/Mx

	# enable the fool-script
	MYWD=`echo ${WORKDIR} | sed -re 's/\//\\\\\//g'`
	sed -r \
		-e "s/\\$\_MONETDB\_INCLUDEDIR/${MYWD}\/MonetDB-${PV}\/include/g" \
		-e "s/\\$\_MONETDB\_VERSION/${PV}/g" \
		-e "s/\\$\_MONETDB\_LIBS/-L${MYWD}\/MonetDB-${PV}\/lib\/MonetDB -L${MYWD}\/MonetDB-${PV}\/lib/g" \
		-e "s/\\$\_MONETDB\_MOD_PATH/${MYWD}\/MonetDB-${PV}\/include/g" \
		-e "s/\\$\_MONETDB\_PREFIX/${MYWD}\/MonetDB-${PV}/g" \
		-e "s/\\$\_MONETDB\_CLASSPATH/${MYWD}\/MonetDB-${PV}\/src\/mapi\/clients\/java\/mapi.jar/g" \
		${FILESDIR}/monetdb_config.sh > \
			${WORKDIR}/MonetDB-${PV}/bin/monetdb-config
	chmod 744 ${WORKDIR}/MonetDB-${PV}/bin/monetdb-config

	# configure and make SQL
	cd ${WORKDIR}/sql-${PV_SQL}
	econf MONETDB_CONFIG=${WORKDIR}/MonetDB-${PV}/bin/monetdb-config \
		"--with-monet=${WORKDIR}/MonetDB-${PV}" \
		"--enable-optimize" \
		`use_with java` || die
	emake || die "emake sql failed"

	# configure and make XQuery, because it relies on >=bison-1.33 which we
	# might not have, we apply a special patch with bison 2.0 generated
	# files.  This is especially useful for OSX users, as this allows
	# them to use this package without having to overwrite their system
	# installed bison 1.28
	cd ${WORKDIR}/pathfinder-${PV_XQ}
	# has_version/best_version do not take package.provided into
	# account! thus we assume OSX users don't have the right bison :(
	if use ppc-macos; then
		einfo "extracting extra files for older bison users"
		tar -jxf ${DISTDIR}/monetdb-pathfinder-bison-sources-${PV_XQ}.tar.bz2
	fi
	econf MONETDB_CONFIG=${WORKDIR}/MonetDB-${PV}/bin/monetdb-config \
		"--with-monet=${WORKDIR}/MonetDB-${PV} " \
		"--enable-optimize" || die
	emake || die "emake xquery failed"
}

src_install() {
	# The tar has capitals, the ebuild doesn't...
	cd ${WORKDIR}/MonetDB-${PV}
	einstall || die "failed to install monetdb"

	cd ${WORKDIR}/sql-${PV_SQL}
	einstall || die "failed to install sql"

	cd ${WORKDIR}/pathfinder-${PV_XQ}
	einstall || die "failed to install xquery"

	exeinto /etc/init.d/
	newexe ${FILESDIR}/${PN}.init-${PV} monetdb || die "init.d script"

	insinto /etc/conf.d/
	newins ${FILESDIR}/${PN}.conf-${PV} monetdb || die "conf.d file"

	diropts -m750
	dodir ${DATA_DIR} /var/log/${PN}

	exeinto ${DATA_DIR}
	newexe ${FILESDIR}/${PN}-start.sh ${PN}-start.sh || die "start script"
	newexe ${FILESDIR}/${PN}-stop.sh ${PN}-stop.sh || die "stop script"

	insinto ${DATA_DIR}
	newins ${FILESDIR}/${PN}-${PV}-startup.mil ${PN}-startup.mil || die "startup MIL script"

	# set right permissions
	chown -R monetdb:monetdb ${D}/${DATA_DIR}
	fowners monetdb:monetdb /var/log/${PN}

	# remove Mx and mel, they are only needed for compilation
	rm -f ${D}/usr/bin/Mx ${D}/usr/bin/mel ${D}/usr/bin/idxmx
	# remove windows crap
	rm -f ${D}/usr/bin/*.bat
	# remove perl DBD on ppc-macos, since it gets installed in the wrong
	# location and getting it right is not just a simple thing
	use ppc-macos && rm -Rf ${D}/usr/Network > /dev/null
}

pkg_postinst() {
	while read line; do einfo "${line}"; done <<EOF
MonetDB has been installed on your system, using data directory
${DATA_DIR}.  To get started using SQL, XQuery or MIL see:

http://monetdb.cwi.nl/GettingStarted/

If you have upgraded from version 4.6.2 or below you should restore your
SQL databases, as well as convert your MIL BATs.  See also:
http://monetdb.cwi.nl/TechDocs/FrontEnds/SQL/upgrade/
http://monetdb.cwi.nl/TechDocs/FrontEnds/mil/upgrade/
EOF
}
