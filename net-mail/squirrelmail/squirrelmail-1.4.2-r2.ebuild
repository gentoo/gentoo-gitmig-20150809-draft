# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/squirrelmail/squirrelmail-1.4.2-r2.ebuild,v 1.6 2004/04/01 17:14:22 eradicator Exp $

inherit webapp-apache

DESCRIPTION="Webmail for nuts!"

# Plugin Versions
USERDATA_VER=0.9-1.4.0
ADMINADD_VER=0.1-1.4.0
VSCAN_VER=0.4-1.4.0
GPG_VER=2.0.1-1.4.2
LDAP_VER=0.4

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/retruserdata/retrieveuserdata.${USERDATA_VER}.tar.gz
	http://www.squirrelmail.org/plugins/admin_add.${ADMINADD_VER}.tar.gz
	http://www.squirrelmail.org/plugins/virus_scan.${VSCAN_VER}.tar.gz
	http://www.squirrelmail.org/plugins/gpg.${GPG_VER}.tar.gz
	http://www.squirrelmail.org/plugins/ldapuserdata-${LDAP_VER}.tar.gz"

HOMEPAGE="http://www.squirrelmail.org/"

IUSE="crypt virus-scan ldap"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND="virtual/php
	dev-perl/DB_File
	crypt? ( app-crypt/gnupg )
	ldap? ( net-nds/openldap )"

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	if [ -L ${HTTPD_ROOT}/${PN} ] ; then
		ewarn "You need to unmerge your old SquirrelMail version first."
		ewarn "SquirrelMail will be installed into ${HTTPD_ROOT}/${PN}"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_unpack() {
	unpack ${P}.tar.bz2

	# Now do the plugins
	cd ${S}/plugins

	unpack admin_add.${ADMINADD_VER}.tar.gz

	unpack retrieveuserdata.${USERDATA_VER}.tar.gz &&
		mv retrieveuserdata/config.php retrieveuserdata/config_default.php

	use virus-scan &&
		unpack virus_scan.${VSCAN_VER}.tar.gz &&
		mv virus_scan/config.php virus_scan/config_default.php

	use crypt &&
		unpack gpg.${GPG_VER}.tar.gz &&
		mv gpg/gpg_local_prefs.txt gpg/gpg_local_prefs_default.txt

	use ldap &&
		unpack ldapuserdata-${LDAP_VER}.tar.gz &&
		epatch ${FILESDIR}/ldapuserdata-${LDAP_VER}-gentoo.patch
}

src_compile() {
	#we need to have this empty function ... default compile hangs
	echo "Nothing to compile"
}

src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}
	dodir ${destdir}
	cp -r . ${D}/${HTTPD_ROOT}/${PN}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}/data
	# Fix permissions
	find ${D}${destdir} -type d | xargs chmod 755
	find ${D}${destdir} -type f | xargs chmod 644

	use virus-scan && chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}/plugins/virus_scan/includes/virussignatures.php ${PN}/plugins/virus_scan/config_default.php
}

pkg_postinst() {
	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}

	einfo "Now copy these following configuration files to their destinations and"
	einfo "edit them to configure your settings.  This is not done automatically so"
	einfo "that your old settings are not disturbed."

	einfo
	einfo "${destdir}/config/config_default.php -> ${destdir}/config/config.php"
	einfo "${destdir}/plugins/retrieveuserdata/config_default.php -> ${destdir}/plugins/retrieveuserdata/config.php"
	use virus-scan && einfo "${destdir}/plugins/virus_scan/config_default.php -> ${destdir}/plugins/virus_scan/config.php"
	use crypt && einfo  "${destdir}/plugins/gpg/gpg_local_prefs_default.txt -> ${destdir}/plugins/gpg/gpg_local_prefs.txt"
	use ldap && einfo  "${destdir}/plugins/ldapuserdata/config_sample.php -> ${destdir}/plugins/ldapuserdata/config.php"

	einfo
	einfo "You should also create the file '${destdir}/config/admins'"
	einfo "containing the users who should have access to administrative options."
	einfo "Put each login on its own line, and be sure to leave a newline at the end of the file."

	einfo
	einfo "You can use the console based configuration tool by executing:"
	einfo "cd ${destdir}/config; perl conf.pl"

	old_ver=`ls ${HTTPD_ROOT}/${PN}-[0-9]* 2>/dev/null`
	if [ ! -z "${old_ver}" ]; then
		einfo ""
		einfo "You will also want to move old SquirrelMail data to"
		einfo "the new location:"
		einfo ""
		einfo "\tmv ${HTTPD_ROOT}/${PN}-OLDVERSION/data/* \\"
		einfo "\t\t${HTTPD_ROOT}/${PN}/data"
		einfo "\tmv ${HTTPD_ROOT}/${PN}-OLDVERSION/config/config.php \\"
		einfo "\t\t${HTTPD_ROOT}/${PN}/config"
	fi
}
