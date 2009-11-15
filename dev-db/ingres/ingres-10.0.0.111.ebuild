# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/ingres/ingres-10.0.0.111.ebuild,v 1.1 2009/11/15 12:11:08 patrick Exp $

EAPI="2"

inherit eutils flag-o-matic versionator

# amd64 doesn't work yet
KEYWORDS="~x86"
SLOT="0"

# Several Ingres instances can be installed with different
# installation identifiers - default is II
# This is not the same as slotting because we have
# n installations of the same version which is not supported
# by portage (e.g. portage doesn't know which one to unmerge)
II_INSTALLATION=${II_INSTALLATION:-"II"}

# Getting the version strings from the package name
VERSION=$(get_version_component_range 1-3)
SHORT_VERSION=$(get_version_component_range 1-2)
BUILD=$(get_version_component_range 4)

DESCRIPTION="Ingres Relational Database Management System"
HOMEPAGE="http://www.ingres.com/"
SRC_DIR="ingres-${VERSION}-${BUILD}-gpl-src"
SRC_TGZ="${SRC_DIR}.tgz"
DOWNLOAD_URL="http://dev.gentooexperimental.org/~dreeevil/ingres/ingres-${VERSION}-${BUILD}-gpl-src.tgz"
SRC_URI="${DOWNLOAD_URL}/${SRC_TGZ}"
S="${WORKDIR}/${SRC_DIR}"
LICENSE="GPL-2"

# nodbms means client installation
IUSE="client net das odbc demodb"

RDEPEND="dev-libs/xerces-c
	app-arch/pax"

DEPEND="${RDEPEND}
	app-crypt/mit-krb5
	dev-util/ftjam"

PG_DIR="/var/lib/ingres"

pkg_setup() {
	if use client && use demodb; then
		eerror "Cannot install demodb without the dbms"
		die "Invalid USE flags"
	fi

	if [ -d "${PG_DIR}/Ingres${II_INSTALLATION}" ]; then
		einfo "Existing installation found in ${PG_DIR}/Ingres${II_INSTALLATION}."
		einfo "This installation will be upgraded."
		einfo "If that is not what you want press CTRL-C now!"
		epause 5
	fi

	if ps ax | grep -qe "iigc[n|c|d] ${II_INSTALLATION}"; then
		ewarn ""
		ewarn "Running instance of Ingres ${II_INSTALLATION} found!"
		ewarn "Ingres will be compiled and merged but not configured"
		ewarn "when another copy of the same instance is running."
		ewarn "You can do that afterwards with "
		ewarn "USE=\"...\" emerge --config ingres"
		epause 5
	fi

	enewgroup ingres
	enewuser ingres -1 /bin/bash ${PG_DIR} ingres
}

src_prepare() {
	epatch "${FILESDIR}/${SHORT_VERSION}-bldenv.patch"
	epatch "${FILESDIR}/${SHORT_VERSION}-sharelib.patch"
	epatch "${FILESDIR}/${SHORT_VERSION}-Jamdefs.patch"
	epatch "${FILESDIR}/sql.patch"
}

src_compile() {
	export ING_ROOT="${S}"

	local paxlocation=`which pax`
	export PAXLOC=`dirname ${paxlocation}`

	source src/tools/port/jam/bldenv || die "Setting of environment failed"

	cd tools/port/jam
	jam || die "Building of mkjams failed"
	mkjams || die "Creation of jam files failed"

	cd "$ING_SRC"

	grep -vE "gtk|rpm|deb|packman|pixmap" front/st/Jamfile > front/st/_Jamfile
	mv front/st/_Jamfile front/st/Jamfile

	einfo "Compiling Ingres..."

	jam -q || die "Building Ingres failed"

}

src_install() {

	einfo "Creating II_SYSTEM..."

	II_SYSTEM="${D}${PG_DIR}/Ingres${II_INSTALLATION}"

	II_LOC="${II_SYSTEM}/ingres"

	mkdir -p "${II_LOC}"

	DIRS="abf bin ckp data demo dmp files ice jnl lib log sig utility work vdba version.rel"

	for DIR in ${DIRS}; do
		echo -n "${DIR} "
		cp -rpLf "${S}/build/${DIR}" "${II_LOC}/" || die "Copying ${DIR} failed"
	done
	echo
	chown -R ingres:ingres "${II_LOC}"

	cat - > ${II_SYSTEM}/.ing${II_INSTALLATION}bash << EOF
export II_SYSTEM=${PG_DIR}/Ingres${II_INSTALLATION}
export PATH=\$II_SYSTEM/ingres/bin:\$II_SYSTEM/ingres/utility:\$PATH
if [ "\$LD_LIBRARY_PATH" ] ; then
    LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/lib:\$II_SYSTEM/ingres/lib
else
    LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib:\$II_SYSTEM/ingres/lib
fi
export LD_LIBRARY_PATH
export TERM=vt100
export TERM_INGRES=vt100fx
EOF

	newinitd "${FILESDIR}/ingres-initd" ingres${II_INSTALLATION} || die "Adding init.d script failed"

	einfo "done."
}

pkg_config() {

	export II_SYSTEM="${PG_DIR}/Ingres${II_INSTALLATION}"

	ERRMSG="Installing Ingres failed
    You may find information in ${II_SYSTEM}/ingres/files/install.log.
    You can retry by executing USE=\"...\" emerge --config ingres"

	if ps ax | grep -qe "iigc[n|c|d] ${II_INSTALLATION}"; then
		eerror "Running instance of Ingres ${II_INSTALLATION} found!"
		eerror "Please stop that instance first, before upgrading."
		die "${ERRMSG}"
	fi

	einfo "Fixing file permissions..."
	chmod u+s "${II_SYSTEM}/ingres/bin/verifydb"
	chmod u+s "${II_SYSTEM}/ingres/bin/ingvalidpw"
	chmod u+s "${II_SYSTEM}/ingres/bin/iimerge"
	chmod u+s "${II_SYSTEM}/ingres/utility/csreport"

	einfo "Setting up Ingres (please wait - this will take a few minutes)"

	PARTS="tm"

	if ! use client; then
		PARTS="${PARTS} dbms"
	fi
	for FLAG in net das odbc demodb; do
		if use ${FLAG}; then
			PARTS="${PARTS} ${FLAG}"
		fi
	done

	for PART in ${PARTS}; do
		einfo "${PART}..."
		if [ ${PART} == "demodb" ]; then
			su ingres -c "
				. ${II_SYSTEM}/.ing${II_INSTALLATION}bash
				cd ${II_SYSTEM}/ingres/demo/data
				ingstart > /dev/null
				if createdb -n demodb > /dev/null; then
						sql demodb < copy.in > /dev/null
				fi" || die "${ERRMSG}"
		else
			su ingres -c "
				. ${II_SYSTEM}/.ing${II_INSTALLATION}bash
				export II_INSTALLATION=${II_INSTALLATION}
				${II_SYSTEM}/ingres/utility/iisu${PART} -batch" || die "${ERRMSG}"
		fi
	done

	einfo "Upgrading any existing databases"

	su ingres -c "
		. ${II_SYSTEM}/.ing${II_INSTALLATION}bash
		ingstart > /dev/null 2>&1
		upgradedb -all > /dev/null
		ingstop > /dev/null" || die "${ERRMSG}"

	su ingres -c "
		. ${II_SYSTEM}/.ing${II_INSTALLATION}bash
		ingsetenv ING_ABFDIR ${II_SYSTEM}/ingres/abf" || die "${ERRMSG}"

	"${II_SYSTEM}/ingres/bin/mkvalidpw" > /dev/null || die "${ERRMSG}"

	einfo "Done."

}

pkg_postinst() {

	pkg_config

	elog ""
	elog "Run '/etc/init.d/ingres${II_INSTALLATION} start' to start Ingres"
	elog ""
	elog "After that, as user ingres type"
	elog "  source ${PG_DIR}/Ingres${II_INSTALLATION}/.ing${II_INSTALLATION}bash"
	elog "to run the Ingres commands such as sql or createdb."

}
