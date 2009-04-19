# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/centreon/centreon-1.4.2.7.ebuild,v 1.1 2009/04/19 17:37:25 hollow Exp $

inherit depend.apache depend.php confutils

DESCRIPTION="Centreon is a monitoring web-frontend based on the nagios monitoring engine"
HOMEPAGE="http://www.oreon-project.org"
SRC_URI="http://download.centreon.com/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-path_sanity.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap"

DEPEND=""
RDEPEND=">=net-analyzer/nagios-2.10
	net-analyzer/rrdtool
	net-analyzer/net-snmp
	net-analyzer/snmptt
	app-admin/sudo
	dev-php/PEAR-PEAR
	dev-php/smarty
	>=dev-php/PEAR-Auth_SASL-1.0.1
	>=dev-php/PEAR-DB-1.7.6
	>=dev-php/PEAR-DB_DataObject-1.8.4
	>=dev-php/PEAR-DB_DataObject_FormBuilder-1.0.0_rc4
	>=dev-php/PEAR-Date-1.4.6
	>=dev-php/PEAR-HTML_Common-1.2.2
	>=dev-php/PEAR-HTML_QuickForm-3.2.5
	>=dev-php/PEAR-HTML_QuickForm_advmultiselect-1.1.0
	>=dev-php/PEAR-HTML_Table-1.6.1
	>=dev-php/PEAR-HTTP-1.2.2
	>=dev-php/PEAR-Image_Canvas-0.2.4
	>=dev-php/PEAR-Image_Color-1.0.2
	>=dev-php/PEAR-Image_Graph-0.7.1
	>=dev-php/PEAR-Image_GraphViz-1.1.0
	>=dev-php/PEAR-MDB2-2.0.0
	>=dev-php/PEAR-Mail-1.1.9
	>=dev-php/PEAR-Mail_Mime-1.3.1
	>=dev-php/PEAR-Net_Ping-2.4.1
	>=dev-php/PEAR-Net_SMTP-1.2.8
	>=dev-php/PEAR-Net_Socket-1.0.1
	>=dev-php/PEAR-Net_Traceroute-0.21
	>=dev-php/PEAR-Numbers_Roman-1.0.1
	>=dev-php/PEAR-Numbers_Words-0.14.0
	>=dev-php/PEAR-SOAP-0.10.1
	>=dev-php/PEAR-Validate-0.6.2
	dev-perl/Config-IniFiles
	dev-perl/Crypt-DES
	dev-perl/DBI
	dev-perl/Digest-HMAC
	dev-perl/Digest-SHA1
	dev-perl/GD
	dev-perl/IO-Socket-INET6
	dev-perl/Net-SNMP
	dev-perl/Socket6"

need_apache2
need_php5

setup_vars() {
	INSTALL_DIR_OREON="/usr/share/centreon"
	OREON_PATH=${INSTALL_DIR_OREON}

	INSTALL_DIR_NAGIOS="/usr"
	NAGIOS_ETC="/etc/nagios"
	NAGIOS_VAR="/var/nagios"
	NAGIOS_BIN="/usr/sbin"
	NAGIOS_PLUGINS="/usr/lib/nagios/plugins"
	NAGIOS_IMG="/usr/share/nagios/htdocs/images"
	NAGIOS_USER="nagios"
	NAGIOS_GROUP="nagios"

	BIN_RRDTOOL="/usr/bin/rrdtool"
	BIN_MAIL="/bin/mail"
}

pkg_setup() {
	confutils_require_built_with_all sys-devel/libperl ithreads
	confutils_require_built_with_all dev-lang/perl ithreads
	confutils_require_built_with_all net-analyzer/net-snmp perl
	confutils_require_built_with_all net-analyzer/rrdtool perl

	require_php_sapi_from apache2 cli
	require_php_with_any_use gd gd-external
	require_php_with_use mysql posix snmp truetype

	use ldap && require_php_with_use ldap

	setup_vars
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${P}-path_sanity.patch
	epatch "${FILESDIR}"/${P}-dashboard-backdoor.patch
}

varsubst() {
	local path=$1

	for var in "$@"; do
		sed -i -e "s:@${var}@:$(eval echo \$${var}):g" "${D}${path}"
	done
}

install_centreon() {
	cd "${S}"

	# copy www and doc files
	insinto "${OREON_PATH}"
	doins -r www
	dosym /usr/nagios/share/doc "${OREON_PATH}"/doc

	# sanitize file modes
	find "${D}${OREON_PATH}" -type d -exec chmod 755 {} \;
	find "${D}${OREON_PATH}" -type f -exec chmod 644 {} \;

	# keep important directories
	keepdir "${OREON_PATH}"/www/modules
	keepdir /var/log/centreon
	keepdir /var/cache/centreon/rrd
	keepdir /var/cache/centreon/smarty/{cache,config,compile}
	keepdir /var/cache/centreon/generate/{nagiosCFG,osm}
	keepdir /var/cache/centreon/upload/nagiosCFG

	# prepare SQL files
	varsubst "${OREON_PATH}"/www/install/insertBaseConf.sql \
		NAGIOS_{USER,GROUP,ETC,BIN,VAR,PLUGINS,IMG} \
		INSTALL_DIR_NAGIOS INSTALL_DIR_OREON \
		BIN_RRDTOOL BIN_MAIL

	varsubst "${OREON_PATH}"/www/install/createTablesODS.sql \
		NAGIOS_VAR

	# fix paths in php files
	varsubst "${OREON_PATH}"/www/include/configuration/configCGI/formCGI.php \
		NAGIOS_ETC INSTALL_DIR_NAGIOS

	varsubst "${OREON_PATH}"/www/include/options/oreon/upGrade/preUpdate.php \
		OREON_PATH

	# install apache config
	insinto "${APACHE_MODULES_CONFDIR}"
	doins "${FILESDIR}"/99_centreon.conf

	# install global installation config
	insinto "${OREON_PATH}"/www/install
	doins "${FILESDIR}"/installoreon.conf.php

	# set permissions
	fowners -R apache:apache \
		/var/cache/centreon \
		"${OREON_PATH}"/www

	fowners -R nagios:apache \
		/var/log/centreon
}

install_plugins() {
	cd "${S}"

	# install plugin configuration
	insinto /etc/centreon
	doins ./Plugins/src/centreon.conf
	rm -f ./Plugins/src/centreon.conf

	varsubst /etc/centreon/centreon.conf \
		INSTALL_DIR_NAGIOS INSTALL_DIR_OREON \
		NAGIOS_ETC NAGIOS_PLUGINS

	fowners -R apache:apache \
		/etc/centreon

	# install nagios plugins
	exeinto "${NAGIOS_PLUGINS}"

	for plugin in ./Plugins/src/*; do
		if [[ ! -d "${plugin}" ]]; then
			doexe "${plugin}"
			varsubst "${NAGIOS_PLUGINS}/$(basename "${plugin}")" \
				NAGIOS_PLUGINS NAGIOS_VAR
		fi
	done
}

install_traps() {
	cd "${S}"

	# install snmp traps plugins
	dodir "${NAGIOS_PLUGINS}"/traps
	dodir /etc/snmp/centreon

	exeinto "${NAGIOS_PLUGINS}"/traps/
	doexe Plugins/src/traps/plugins/*

	# install snmp configs
	insinto /etc/snmp/centreon
	doins Plugins/src/traps/conf/snmptt.ini
	fowners -R apache:nagios /etc/snmp/centreon

	insinto /etc/snmp/
	doins Plugins/src/traps/conf/snmp.conf
}

install_ods() {
	cd "${S}"

	# install ODS daemon
	insinto /usr
	dosbin ODS/ods

	# install ODS library files
	insinto /usr/lib/ods
	doins ODS/lib/*

	# install ODS init script
	newinitd "${FILESDIR}"/ods.initd ods

	# keep important directories
	keepdir /etc/ods
	keepdir /var/run/ods
	keepdir /var/log/ods
	keepdir /var/lib/ods
	keepdir /var/lib/ods/database

	# set permissions
	fowners -R nagios:nagios \
		/var/run/ods \
		/var/log/ods \
		/var/lib/ods/database
	fowners -R apache:nagios /etc/ods
}

install_cron() {
	cd "${S}"

	insinto "${OREON_PATH}"
	doins -r cron

	fperms +x "${OREON_PATH}"/cron/*.{pl,php}

	for i in $(find cron/ -type f); do
		varsubst "${OREON_PATH}"/${i} OREON_PATH
	done

	insinto /etc/cron.d
	newins "${FILESDIR}"/centreon.cron centreon
}

src_install() {
	install_centreon
	install_plugins
	install_traps
	install_ods
	install_cron
}

pkg_config() {
	setup_vars

	einfo "Setting permissions on ${ROOT}${NAGIOS_ETC}"
	chown apache:nagios "${ROOT}${NAGIOS_ETC}"
	chmod 0775 "${ROOT}${NAGIOS_ETC}"

	einfo "Setting permissions on ${ROOT}${NAGIOS_PLUGINS}"
	chown apache:nagios "${ROOT}${NAGIOS_PLUGINS}"
	chmod 0775 "${ROOT}${NAGIOS_PLUGINS}"

	einfo "Setting permissions on ${ROOT}${NAGIOS_PLUGINS}/contrib"
	chown apache:nagios "${ROOT}${NAGIOS_PLUGINS}"/contrib
	chmod 0775 "${ROOT}${NAGIOS_PLUGINS}"/contrib

	einfo "Adding user apache to group nagios"
	usermod -a -G nagios apache

	SUDOERS="${ROOT}etc/sudoers"

	if ! grep -q CENTREON "${SUDOERS}"; then
		einfo "Adding sudo configuration"
		echo >> "${SUDOERS}"
		echo "# centreon configuration" >> "${SUDOERS}"
		echo "User_Alias  CENTREON=apache" >> "${SUDOERS}"
		echo "CENTREON    ALL = NOPASSWD: /etc/init.d/nagios restart" >> "${SUDOERS}"
		echo "CENTREON    ALL = NOPASSWD: /etc/init.d/nagios reload"  >> "${SUDOERS}"
		echo "CENTREON    ALL = NOPASSWD: /etc/init.d/snmptrapd restart" >> "${SUDOERS}"
	fi
}
