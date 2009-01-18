# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqldeveloper/sqldeveloper-1.5.3.5783.ebuild,v 1.2 2009/01/18 05:48:49 bluebird Exp $

EAPI="2"

inherit eutils versionator

MY_PV="$(get_version_component_range 4)"

DESCRIPTION="Oracle SQL Developer is a graphical tool for database development"
HOMEPAGE="http://www.oracle.com/technology/products/database/sql_developer/"
SRC_URI="${PN}-${MY_PV}-no-jre.zip"
RESTRICT="fetch"

LICENSE="OTN"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mssql mysql sybase"

DEPEND="mssql? ( dev-java/jtds )
	mysql? ( dev-java/jdbc-mysql )
	sybase? ( dev-java/jtds )"
RDEPEND=">=virtual/jdk-1.5.0
	${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_nofetch() {
	eerror "Please go to"
	eerror "	${HOMEPAGE}"
	eerror "and download"
	eerror "	Oracle SQL Developer for other platforms"
	eerror "		${SRC_URI}"
	eerror "and move it to ${DISTDIR}"
}

src_prepare() {
	# we don't need these, do we?
	find ./ -iname "*.exe" -or -iname "*.dll" -exec rm {} \;
}

src_configure() {
	# they both use jtds, enabling one of them also enables the other one
	if use mssql && ! use sybase; then
		einfo "You requested MSSQL support, this also enables Sybase support."
	fi
	if use sybase && ! use mssql; then
		einfo "You requested Sybase support, this also enables MSSQL support."
	fi

	if use mssql || use sybase; then
		jtds_version="$(best_version dev-java/jtds)"
		jtds_version="${jtds_version/dev-java\/jtds-/}"
		jtds_version="${jtds_version/-*/}"

		if [ ! -e "${ROOT}/usr/share/jtds-${jtds_version}/lib/jtds.jar" ]; then
			eerror "$(best_version dev-java/jtds) does not provide jtds.jar!"
			die "Cannot find jtds.jar"
		fi

		echo "AddJavaLibFile /usr/share/jtds-${jtds_version}/lib/jtds.jar" \
			>> sqldeveloper/bin/sqldeveloper.conf
	fi

	if use mysql; then
		if [ ! -e "${ROOT}"/usr/share/jdbc-mysql/lib/jdbc-mysql.jar ]; then
			eerror "$(best_version jdbc-mysql) does not provide jdbc-mysql.jar!"
			die "Cannot find jdbc-mysql.jar"
		fi

		echo "AddJavaLibFile /usr/share/jdbc-mysql/lib/jdbc-mysql.jar" \
			>> sqldeveloper/bin/sqldeveloper.conf
	fi
}

src_install() {
	dodir /opt/${PN}
	cp -r {BC4J,dvt,ide,j2ee,jdbc,jdev,jlib,lib,rdbms,${PN},timingframework} \
		"${D}"/opt/${PN}/ || die "Install failed"

	dobin "${FILESDIR}"/${PN} || die "Install failed"

	mv icon.png ${PN}-32x32.png
	mv raptor_image.jpg ${PN}-48x48.jpg
	doicon ${PN}-32x32.png ${PN}-48x48.jpg
	make_desktop_entry ${PN} "Oracle SQL Developer" ${PN}-32x32

	dodoc relnotes.html
}

pkg_postinst() {
	echo
	einfo "If you want to use the TNS connection type you need to set up the"
	einfo "TNS_NAMES environment variable to point to the directory your"
	einfo "tnsnames.ora resides in."
	echo
}
