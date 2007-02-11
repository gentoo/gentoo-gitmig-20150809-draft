# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/monetdb/monetdb-4.10.2.ebuild,v 1.8 2007/02/11 14:12:38 grobian Exp $

inherit flag-o-matic eutils

DESCRIPTION="A main-memory relational database for SQL, XQuery and MIL"
HOMEPAGE="http://monetdb.cwi.nl/"
IUSE="java readline debug"
PV_SQL=2.10.2
PV_XQ=0.10.2
PV_M=${PV}
SRC_URI="mirror://sourceforge/monetdb/MonetDB-${PV_M}.tar.gz
	mirror://sourceforge/monetdb/MonetDB-SQL-${PV_SQL}.tar.gz
	mirror://sourceforge/monetdb/MonetDB-XQuery-${PV_XQ}.tar.gz"
LICENSE="MonetDBPL-1.1 PathfinderPL-1.1"
SLOT="0"
KEYWORDS="ppc x86"
RESTRICT="test"

DEPEND="virtual/libc
		>=sys-devel/gcc-3.3
		java? ( >=virtual/jdk-1.4 )
		java? ( dev-java/ant-core )
		readline? ( >=sys-libs/readline-4.1 )
		dev-libs/libxml2
		>=dev-libs/libpcre-5"

DATA_DIR="/var/lib/MonetDB"

pkg_setup() {
	# see if we have a dbfarm, and whether there is a version of monetdb
	# installed which is not a version that we can 'upgrade' to.
	if [ -x "${DATA_DIR}/dbfarm" ] || [ -x "${DATA_DIR}/log" ];
	then
		if [ -x "/usr/bin/monetdb-config" ] && \
			[ "`/usr/bin/monetdb-config --version`" != "${PV_M}" ];
		then
			while read line; do eerror "${line}"; done <<EOF
MonetDB ${MY_PV} cannot upgrade your existing SQL databases.  You must
export your existing SQL databases to a file using "JdbcClient -D" and
then restore them when you have upgraded completey using
"JdbcClient -f".  Dumping and restoring of MIL and XQuery databases
unfortunately is not possible at the moment.

You must remove your entire database directory to continue.
(database directory = ${DATA_DIR}).
See the following url for more information on dumping and
restoring your database:
http://monetdb.cwi.nl/TechDocs/FrontEnds/SQL/upgrade/
EOF
			die "Cannot upgrade automatically."
		fi
	fi

	enewgroup monetdb
	enewuser monetdb -1 /bin/bash "${DATA_DIR}" monetdb
}

src_unpack() {
	unpack ${A} || die

	epatch "${FILESDIR}/${PN}-${PV_M}"-gentoo-MapiClient.patch
	epatch "${FILESDIR}/${PN}-${PV_M}"-gentoo-conf.patch
}

src_compile() {
	# The tar has capitals, the ebuild doesn't...
	cd "${WORKDIR}/MonetDB-${PV_M}"

	# setting these respects the user's CFLAGS and disables -Werror etc.
	local myconf="--disable-optimize --disable-debug"
	sed -i \
		-e 's|CFLAGS="\$CFLAGS \\\$(X_CFLAGS)"||' \
		configure || die "failed fixing configure"

	# Gentoo's amd64 doesn't allow 32-bits monetdb to compile, hence we switch
	# to 64-bits Mserver here.  Note that this also gives 64-bits OIDs.
	use amd64 && myconf="${myconf} --enable-bits=64"

	myconf="${myconf} $(use_with java)"
	myconf="${myconf} $(use_with readline)"
	myconf="${myconf} $(use_enable debug assert)"

	econf ${myconf} || die "econf monetdb failed"

	# NOTE: the Makefiles have serious issues with parallel builds.
	# Nothing is guaranteed to work but a single process build.
	emake -j1 || die "emake monetdb failed"

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

	cd "${WORKDIR}/MonetDB-${PV_M}"
	mkdir -p lib/MonetDB
	cd lib/MonetDB
	find ../.. -name "lib_*" -exec ln -s {} ';' >& /dev/null
	ln -s . .libs

	cd "${WORKDIR}/MonetDB-${PV_M}/lib"
	find .. -name "lib*" -exec ln -s {} ';' >& /dev/null
	ln -s . .libs

	# enable the fool-script
	mkdir -p "${WORKDIR}/MonetDB-${PV_M}/bin"
	MYWD=`echo ${WORKDIR} | sed -re 's/\//\\\\\//g'`
	sed -r \
		-e "s/\\$\_MONETDB\_INCLUDEDIR/${MYWD}\/MonetDB-${PV_M}\/include/g" \
		-e "s/\\$\_MONETDB\_VERSION/${PV_M}/g" \
		-e "s/\\$\_MONETDB\_LIBS/-L${MYWD}\/MonetDB-${PV_M}\/lib\/MonetDB -L${MYWD}\/MonetDB-${PV_M}\/lib/g" \
		-e "s/\\$\_MONETDB\_MOD_PATH/${MYWD}\/MonetDB-${PV_M}\/include/g" \
		-e "s/\\$\_MONETDB\_PREFIX/${MYWD}\/MonetDB-${PV_M}/g" \
		-e "s/\\$\_MONETDB\_CLASSPATH/${MYWD}\/MonetDB-${PV_M}\/src\/mapi\/clients\/java\/mapi.jar/g" \
		"${FILESDIR}/monetdb_config.sh" > \
			"${WORKDIR}/MonetDB-${PV_M}/bin/monetdb-config"
	chmod 744 "${WORKDIR}/MonetDB-${PV_M}/bin/monetdb-config"

	# configure and make SQL
	cd "${WORKDIR}/sql-${PV_SQL}"
	econf MONETDB_CONFIG="${WORKDIR}/MonetDB-${PV_M}/bin/monetdb-config" \
		"--with-monet=${WORKDIR}/MonetDB-${PV_M}" \
		${myconf} \
		|| die
	emake -j1 || die "emake sql failed"

	# configure and make XQuery
	cd "${WORKDIR}/pathfinder-${PV_XQ}"
	econf MONETDB_CONFIG="${WORKDIR}/MonetDB-${PV_M}/bin/monetdb-config" \
		"--with-monet=${WORKDIR}/MonetDB-${PV_M} " \
		${myconf} || die
	emake -j1 || die "emake xquery failed"
}

src_install() {
	# The tar has capitals, the ebuild doesn't...
	cd "${WORKDIR}/MonetDB-${PV_M}"
	emake -j1 DESTDIR="${D}" install || die "failed to install monetdb"

	cd "${WORKDIR}/sql-${PV_SQL}"
	emake -j1 DESTDIR="${D}" install || die "failed to install sql"

	cd "${WORKDIR}/pathfinder-${PV_XQ}"
	emake -j1 DESTDIR="${D}" install || die "failed to install xquery"

	exeinto /etc/init.d/
	newexe "${FILESDIR}/${PN}.init-4.8.2" monetdb || die "init.d script"

	insinto /etc/conf.d/
	newins "${FILESDIR}/${PN}.conf-4.8.2" monetdb || die "conf.d file"

	diropts -m750
	dodir "${DATA_DIR}" "/var/log/${PN}"

	exeinto "${DATA_DIR}"
	newexe "${FILESDIR}/${PN}-start.sh" "${PN}-start.sh" || die "start script"
	newexe "${FILESDIR}/${PN}-stop.sh" "${PN}-stop.sh" || die "stop script"

	insinto "${DATA_DIR}"
	newins "${FILESDIR}/${PN}-4.8.2-startup.mil" "${PN}-startup.mil" \
		|| die "startup MIL script"

	if use java;
	then
		exeinto /usr/bin
		newexe "${FILESDIR}/${PN}.JdbcClient-4.10.0" "JdbcClient" \
			|| die "JdbcClient alias"
	fi

	# set right permissions
	chown -R monetdb:monetdb "${D}/${DATA_DIR}" \
		|| die "setting ownership on ${DATA_DIR} failed"
	fowners monetdb:monetdb "/var/log/${PN}" \
		|| die "setting ownership on /var/log/${PN} failed"

	# remove testing framework and compiled tests
	rm -f \
		"${D}/usr/bin/Mapprove.py" \
		"${D}/usr/bin/Mdiff" \
		"${D}/usr/bin/Mfilter.py" \
		"${D}/usr/bin/MkillUsers" \
		"${D}/usr/bin/Mlog" \
		"${D}/usr/bin/Mprofile.py" \
		"${D}/usr/bin/Mtest.py" \
		"${D}/usr/bin/Mtimeout" \
		"${D}/usr/bin/prof.py" \
		"${D}/usr/share/MonetDB/Mprofile-commands.lst" \
		|| die "removing testing tools"
	rm -Rf \
		"${D}/usr/lib/MonetDB/Tests" \
		"${D}/usr/lib/sql/Tests" \
		"${D}/usr/share/MonetDB/Tests" \
		"${D}/usr/share/sql/Tests" \
		|| die "removing tests"
	# remove pf_burk, upstream only compiles it, but doesn't use it
	rm -f \
		"${D}/usr/lib/MonetDB/pf_burk.mil" \
		"${D}/usr/lib/MonetDB/lib_pf_burk.so.0.0.0" \
		"${D}/usr/lib/MonetDB/lib_pf_burk.so.0" \
		"${D}/usr/lib/MonetDB/lib_pf_burk.so" \
		"${D}/usr/lib/MonetDB/lib_pf_burk.la" \
		|| die "removing incomplete Burkowski step support"
	# remove windows cruft
	find "${D}" -name "*.bat" | xargs rm -f || die "removing windows stuff"
}

src_test() {
	# Upstream has tests that work in their "lab-setting".  They prefer to wait
	# using it when they provide a set of tests that is meant to be used
	# outside their "labs".  Those tests will also be supposed not to fail...
	true
}

pkg_postinst() {
	while read line; do elog "${line}"; done <<EOF
MonetDB has been installed on your system, using data directory
${DATA_DIR}.
To get started using SQL, XQuery or MIL see:

http://monetdb.cwi.nl/GettingStarted/
EOF
}
