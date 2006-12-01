# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/squirrelmail/squirrelmail-1.5.1-r1.ebuild,v 1.5 2006/12/01 13:54:52 mcummings Exp $

IUSE="crypt ldap spell ssl filter mysql postgres nls"

inherit webapp eutils

DESCRIPTION="Webmail for nuts!"

# Plugin Versions
COMPATIBILITY_VER=2.0.4
USERDATA_VER=0.9-1.4.0
ADMINADD_VER=0.1-1.4.0
AMAVIS_VER=0.8.0-1.4
GPG_VER=2.0.1-1.4.2
LDAP_USERDATA_VER=0.4
SECURELOGIN_VER=1.2-1.2.8
SHOWSSL_VER=2.1-1.2.8
LOCALES_VER=1.5.1-20060219

MY_P=${P/_rc/-RC}
S="${WORKDIR}/${MY_P}"

PLUGINS_LOC="http://www.squirrelmail.org/plugins"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	mirror://sourceforge/retruserdata/retrieveuserdata.${USERDATA_VER}.tar.gz
	${PLUGINS_LOC}/compatibility-${COMPATIBILITY_VER}.tar.gz
	ssl? ( ${PLUGINS_LOC}/secure_login-${SECURELOGIN_VER}.tar.gz )
	ssl? ( ${PLUGINS_LOC}/show_ssl_link-${SHOWSSL_VER}.tar.gz )
	${PLUGINS_LOC}/admin_add.${ADMINADD_VER}.tar.gz
	filter? ( ${PLUGINS_LOC}/amavisnewsql-0.8.0-1.4.tar.gz )
	crypt? ( ${PLUGINS_LOC}/gpg.${GPG_VER}.tar.gz )
	ldap? ( ${PLUGINS_LOC}/ldapuserdata-${LDAP_USERDATA_VER}.tar.gz )
	nls? ( mirror://sourceforge/${PN}/all_locales-${LOCALES_VER}.tar.bz2 )"

HOMEPAGE="http://www.squirrelmail.org/"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND=""

RDEPEND="virtual/php
	virtual/perl-DB_File
	crypt? ( app-crypt/gnupg )
	ldap? ( net-nds/openldap )
	spell? ( || ( app-text/aspell app-text/ispell ) )
	filter? ( mail-filter/amavisd-new dev-php/PEAR-Log dev-php/PEAR-DB dev-php/PEAR-Net_SMTP )
	postgres? ( dev-php/PEAR-DB )
	mysql? ( dev-php/PEAR-DB )"

src_unpack() {
	unpack ${MY_P}.tar.bz2

	cd ${S}

	mv config/config_default.php config/config.php

	sed -i "s:'/var/local/squirrelmail/data':SM_PATH . 'data/':" config/config.php

	# Now do the plugins
	cd ${S}/plugins

	mv fortune/config_default.php fortune/config.php
	sed -i 's:/usr/games/fortune:/usr/bin/fortune:g' fortune/config.php

	mv bug_report/config_default.php bug_report/config.php
	mv change_password/config_default.php change_password/config.php
	mv filters/config_default.php filters/config.php
	mv mail_fetch/config_sample.php mail_fetch/config.php
	mv newmail/config_default.php newmail/config.php
	mv translate/config_default.php translate/config.php

	rm newmail/config_sample.php
	rm translate/config_sample.php

	unpack compatibility-${COMPATIBILITY_VER}.tar.gz

	unpack admin_add.${ADMINADD_VER}.tar.gz

	unpack retrieveuserdata.${USERDATA_VER}.tar.gz

	use filter &&
		unpack amavisnewsql-${AMAVIS_VER}.tar.gz &&
		mv amavisnewsql/config.php.dist amavisnewsql/config.php

	use crypt &&
		unpack gpg.${GPG_VER}.tar.gz

	use ldap &&
		unpack ldapuserdata-${LDAP_USERDATA_VER}.tar.gz &&
		epatch ${FILESDIR}/ldapuserdata-${LDAP_USERDATA_VER}-gentoo.patch &&
		mv ldapuserdata/config_sample.php ldapuserdata/config.php

	use ssl &&
		unpack secure_login-${SECURELOGIN_VER}.tar.gz &&
		mv secure_login/config.php.sample secure_login/config.php &&
		unpack show_ssl_link-${SHOWSSL_VER}.tar.gz &&
		mv show_ssl_link/config.php.sample show_ssl_link/config.php

	use nls &&
		cd ${S} &&
		unpack all_locales-${LOCALES_VER}.tar.bz2
}

src_compile() {
	#we need to have this empty function ... default compile hangs
	echo "Nothing to compile"
}

src_install() {
	webapp_src_preinst

	# Copy the app's main files
	einfo "Installing squirrelmail files."
	cp -r . ${D}${MY_HTDOCSDIR}

	keepdir ${MY_HTDOCSDIR}/data

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!

	for doc in AUTHORS COPYING ChangeLog INSTALL README ReleaseNotes UPGRADE ; do
		dodoc ${doc}
		rm -f ${D}${MY_HTDOCSDIR}/${doc}
	done

	for doc in plugins/{README.plugins,*/{INSTALL,README,COPYRIGHTS,CHANGELOG,API,UPGRADE,TODO,README.txt,INSTALL.txt,user_example.txt}} ; do
		if [[ -f ${doc} ]] ; then
			docinto $(dirname ${doc})
			dodoc ${doc}
			rm -f ${D}${MY_HTDOCSDIR}/${doc}
		fi
	done

	# Identify the configuration files that this app uses
	for file in config/config.php plugins/*/{config.php,sqspell_config.php,gpg_local_prefs.txt}; do
		if [[ -f ${file} ]] ; then
			webapp_configfile ${MY_HTDOCSDIR}/${file}
		fi
	done

	# Identify any script files that need #! headers adding to run under
	# a CGI script (such as PHP/CGI)
	#
	# for phpmyadmin, we *assume* that all .php files that don't end in
	# .inc.php need to have CGI/BIN support added

	#for x in `find . -name '*.php' -print | grep -v 'inc.php'` ; do
	#	webapp_runbycgibin php ${MY_HTDOCSDIR}/$x
	#done

	local server_owned="data index.php"
	for file in ${server_owned}; do
		webapp_serverowned ${MY_HTDOCSDIR}/${file}
	done

	# add the post-installation instructions
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	# all done
	#
	# now we let the eclass strut its stuff ;-)

	webapp_src_install
}
