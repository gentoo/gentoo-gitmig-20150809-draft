# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/net2ftp/net2ftp-0.95.ebuild,v 1.1 2007/03/23 16:24:39 uberlord Exp $

inherit eutils webapp

IUSE=""

MY_P="${PN}_v${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Web-based FTP client in php"
SRC_URI="http://www.net2ftp.com/download/${MY_P}.zip"
HOMEPAGE="http://www.net2ftp.com/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND="virtual/php"

src_unpack() {
	unzip "${DISTDIR}/${MY_P}.zip" >/dev/null \
		|| die "failed to unpack ${MY_P}.zip"

	# Remove the .txt extension from our installed documentation
	cd "${S}"
	rename .txt "" *.txt

	# Fix silly file permissions, developer must use Windows ;)
	chmod -R g-w,o-w *
}

src_install() {
	webapp_src_preinst

	local docs="CREDITS CHANGES LICENSE" doc

	dodoc ${docs}
	for doc in ${docs} INSTALL ; do
		rm -f "${doc}"
	done

	cd files_to_upload
	rm -f temp/chmod_this_dir_to_777.txt

	cp -pPR * "${D}/${MY_HTDOCSDIR}"

	webapp_serverowned "${MY_HTDOCSDIR}/temp"

	webapp_configfile "${MY_HTDOCSDIR}/settings.inc.php"
	webapp_configfile "${MY_HTDOCSDIR}/settings_authorizations.inc.php"
	webapp_configfile "${MY_HTDOCSDIR}/settings_screens.inc.php"

	cd ..
	webapp_sqlscript mysql create_tables.sql

	webapp_src_install
}
