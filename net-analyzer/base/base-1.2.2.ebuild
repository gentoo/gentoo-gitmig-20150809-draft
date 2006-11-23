# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/base/base-1.2.2.ebuild,v 1.2 2006/11/23 19:45:10 vivo Exp $

inherit webapp versionator eutils depend.apache depend.php

CONF_DIR="/etc/${PN}"
CONF_OLD="base_conf.php.dist"
CONF_NEW="base_conf.php"
MIDDLEMAN="base_path.php"

DESCRIPTION="A web-based front-end to the Snort IDS."
HOMEPAGE="http://base.secureideas.net"
SRC_URI="mirror://sourceforge/secureideas/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
# SLOT is intentionally omitted because this package uses webapp-config
IUSE="session apache apache2 mysql postgres mssql oracle gd gd-external"

DEPEND=">=app-arch/tar-1.14
	>=sys-libs/zlib-1.2.1-r3
	>=app-arch/gzip-1.3.5-r4
	>=sys-apps/coreutils-5.2.1-r2
	>=sys-apps/sed-4.0.9
	mysql? ( virtual/mysql )
	postgres? ( >=dev-db/postgresql-7.1.0 )"
	# A local database isn't necessary, so we only require one when the user
	# has use-flags set for one of the supported DBs.
	# Snort can also be installed on a remote system, so we don't require it.

RDEPEND="${DEPEND}
	>=media-libs/gd-1.8.0
	>=dev-php/adodb-1.2
	>=dev-php4/jpgraph-1.12.2
	>=dev-php/PEAR-PEAR-1.3.6-r1
	>=dev-php/PEAR-Image_Color-1.0.2
	>=dev-php/PEAR-Log-1.9.3
	>=dev-php/PEAR-Numbers_Roman-0.2.0
	>=dev-php/PEAR-Numbers_Words-0.14.0
	>=dev-php/PEAR-Image_Canvas-0.2.4
	>=dev-php/PEAR-Image_Graph-0.7.1"

# Require PHP4 to be installed.
need_php4
need_php4_cli

# BASE *should* work with any php-driven web server, so only require Apache
# when the user has an apache use-flag set. Then set the group ownership for
# /etc/base/base_conf.php so it can be read by the user's web server.
if use apache2 || use apache; then
	need_apache
	WWW_GROUP="apache"
else
	# Set a safe default group.
	WWW_GROUP="root"
	APACHE_WWW_GROUP="FALSE"
fi

pkg_setup() {
	webapp_pkg_setup

	# Set the PHP environment variables.
	has_php

	# Make sure php was built with the necessary use-flags.
	require_php_with_use session cli
	require_gd
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Help the user configure /etc/base/base_conf.php so BASE works out of the
	# box in most environments. The user will still be warned to edit the
	# file manually at the pkg_postinst() stage.
	sed -i -e 's:$BASE_urlpath.*:$BASE_urlpath = "/base";:g' \
		${CONF_OLD}
	sed -i -e 's:$DBlib_path.*:$DBlib_path = "/usr/lib/php/adodb";:g' \
		${CONF_OLD}

	if use postgres; then
		sed -i -e 's:$DBtype.*:$DBtype = "postgres";:g' \
			${CONF_OLD}
	fi
	if use mssql; then
		sed -i -e 's:$DBtype.*:$DBtype = "mssql";:g' \
			${CONF_OLD}
	fi
	if use oracle; then
		sed -i -e 's:$DBtype.*:$DBtype = "oci8";:g' \
			${CONF_OLD}
	fi

	# Install the configuration files in the usual /etc/${PN} location so that
	# etc-update functions properly (it also improves security somewhat, since
	# the config file contains plain-text passwords and should not be located
	# inside the web-root). This requires changing the BASE source a tad to
	# recognize the new location for base_conf.php.
	for PHP in *.php */*.php; do
		sed -i -e "s:${CONF_NEW}:${MIDDLEMAN}:g" \
			${CONF_OLD} "${PHP}"
	done

	# Create the file ${MIDDLEMAN} to determine the web-root and to change
	# the location of "include" to /etc/base/base_conf.php.
	echo "<?php" > ${MIDDLEMAN}
	echo '  $BASE_path = dirname(__FILE__);' >> ${MIDDLEMAN}
	echo "  include(\"${CONF_DIR}/${CONF_NEW}\");" >> ${MIDDLEMAN}
	echo "?>" >> ${MIDDLEMAN}

	# Delete the $BASE_path variable from the config file because we
	# now handle it with ${MIDDLEMAN} created above.
	sed -i -e 's:$BASE_path =.*::g' ${CONF_OLD}

	# Modify the HTML headers so search engines don't index BASE.
	sed -i -e \
		's:<HEAD>:<HEAD>\n  <META name="robots" content="noindex,nofollow">:g' \
			index.php
	sed -i -e \
		's:<HEAD>:<HEAD>\n  <META name="robots" content="noindex,nofollow">:g' \
			base_main.php
}

src_install() {
	webapp_src_preinst

	# Install the docs once in the standard /usr/share/doc/${PF}/DOCDESTREE
	# location instead of installing them in every virtual host directory.
	cd docs
	dodoc *
	cd "${S}"
	rm -rf docs

	# Install the config files in the normal location (/etc/${PN}).
	insinto ${CONF_DIR} || die "Unable to insinto ${CONF_DIR}"
	doins ${CONF_OLD} || die "Unable to doins ${CONF_OLD}"
	newins ${CONF_OLD} ${CONF_NEW} || die "Unable to create ${CONF_NEW}"

	# Install BASE for webapp-config
	insinto ${MY_HTDOCSDIR} || die "Unable to insinto ${MY_HTDOCSDIR}"
	doins -r *

	webapp_src_install

	# Set the proper permissions on /etc/base/base_conf.php
	fperms 640 ${CONF_DIR}/${CONF_NEW} || FPERMS="FALSE"
	fowners root:${WWW_GROUP} ${CONF_DIR}/${CONF_NEW} || FOWNERS="FALSE"
}

pkg_postinst() {
	webapp_pkg_postinst

	# Notify the user of any problems at the very end.
	if [ "${APACHE_WWW_GROUP}" == "FALSE" ]; then
			ewarn ""
			ewarn "It looks like you are not using the Apache web server. For "
			ewarn "BASE to work properly, you will need to change the "
			ewarn "ownership on ${CONF_DIR}/${CONF_NEW} to root:[www user]"
	fi

	einfo ""
	einfo "You should edit \"${CONF_DIR}/${CONF_NEW}\" before using BASE."
	einfo ""
	einfo "To setup your initial database, direct your web browser to the"
	einfo "location you installed BASE/base_db_setup.php."
	einfo "You can find instructions in /usr/share/doc/${P}/README."
	einfo ""
}
