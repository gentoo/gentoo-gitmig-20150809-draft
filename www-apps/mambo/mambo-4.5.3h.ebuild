# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mambo/mambo-4.5.3h.ebuild,v 1.1 2006/01/03 15:47:01 rl03 Exp $

inherit webapp

MY_P="${PN/m/M}V${PV}"
DESCRIPTION="Mambo is yet another CMS"
HOMEPAGE="http://www.mamboserver.com/"
SRC_URI="http://mamboforge.net/frs/download.php/7819/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
S=${WORKDIR}

IUSE="mysql"

RDEPEND="mysql? ( dev-db/mysql )
	virtual/httpd-php
	net-www/apache"
DEPEND="app-arch/unzip"

pkg_setup () {
	webapp_pkg_setup
	einfo "Please make sure that your PHP is compiled with XML and MySQL support"
}

src_install () {
	webapp_src_preinst
	local files="administrator/backups administrator/components components
	images images/banners images/stories mambots mambots/content mambots/search
	media language administrator/modules administrator/templates cache modules
	templates"

	dodoc CHANGELOG.php INSTALL.php README

	cp -R [^d]* ${D}/${MY_HTDOCSDIR}

	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

pkg_postinst () {
	einfo "Now run \"emerge --config =${PF}\""
	einfo "if you wish to setup a local database"
	einfo "Note that db and dbuser need to be present prior to running db setup"
	einfo "and your MySQL needs to be running"
	webapp_pkg_postinst
}

pkg_config() {
	# default values for db stuff
	D_DB="mambo"
	D_HOST="localhost"
	D_USER="mambo"

	echo -n "mysql db name [${D_DB}]: "; read MY_DB
	[[ -z ${MY_DB} ]] && MY_DB=${D_DB}

	echo -n "mysql db host [${D_HOST}]: "; read MY_HOST
	[[ -z ${MY_HOST} ]] && MY_HOST=${D_HOST}

	echo -n "mysql dbuser name [${D_USER}]: "; read MY_USER
	[[ -z ${MY_USER} ]] && MY_USER=${D_USER}

	echo -n "mysql dbuser password: "; read mypwd
	[[ -z ${mypwd} ]] && die "Error: no dbuser password"

	# privileges
	echo -n "Please enter login info for user who has grant privileges on ${MY_HOST} [$USER]: "; read adminuser
	[[ -z ${adminuser} ]] && adminuser="$USER"
	if [ "${MY_HOST}" != "localhost" ]; then
		echo -n "Client address (at db side) [$(hostname -f)]: "; read clientaddr
		[[ -z ${clientaddr} ]] && clientaddr="$(hostname -f)"
	fi
	# this will be default for localhost
	[[ -z ${clientaddr} ]] && clientaddr="${MY_HOST}"

	# if $MY_HOST == localhost, don't specify -h argument, so local socket can be used.
	host=${MY_HOST/localhost}
	mysqladmin -u ${adminuser} ${host:+-h ${host}} -p create ${MY_DB} || die "Error creating database"
	mysql -u "${adminuser}" "${host:+-h ${host}}" -p \
		-e "GRANT SELECT,INSERT,UPDATE,DELETE,INDEX,ALTER,CREATE,DROP,REFERENCES
		ON ${MY_DB}.* TO '${MY_USER}'@'${clientaddr}' IDENTIFIED BY '${mypwd}'; FLUSH PRIVILEGES;"  || die "Error initializing database. Please grant permissions manually."
}
