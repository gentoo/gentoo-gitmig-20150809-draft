# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-2.6.3_p1.ebuild,v 1.2 2005/08/21 14:55:48 rl03 Exp $

inherit eutils webapp

MY_P=phpMyAdmin-${PV/_p/-pl}
DESCRIPTION="Web-based administration for MySQL database in PHP"
HOMEPAGE="http://www.phpmyadmin.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~alpha ~ppc ~hppa ~sparc ~x86 ~amd64 ~mips"
IUSE=""
DEPEND=">=dev-db/mysql-3.23.32 <dev-db/mysql-5.1
	virtual/httpd-php
	sys-apps/findutils
	!<=dev-db/phpmyadmin-2.5.6"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/config.inc.php-2.5.6.patch

	# Remove .cvs* files and CVS directories
	find ${S} -name .cvs\* -or \( -type d -name CVS -prune \) | xargs rm -rf
}

src_compile() {
	einfo "Setting random user/password details for the controluser"

	local pmapass="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
	sed -e "s/@pmapass@/${pmapass}/g" -i config.inc.php
	sed -e "s/@pmapass@/${pmapass}/g" \
		${FILESDIR}/mysql-setup.sql.in-2.5.6 > ${T}/mysql-setup.sql
}

src_install() {
	webapp_src_preinst

	local docs="CREDITS ChangeLog Documentation.txt INSTALL README RELEASE-DATE-2.6.3-pl1 TODO"

	# install the SQL scripts available to us
	#
	# unfortunately, we do not have scripts to upgrade from older versions
	# these are things we need to add at a later date

	webapp_sqlscript mysql ${T}/mysql-setup.sql

	dodoc ${docs}

	# Copy the app's main files

	einfo "Installing main files"
	cp -r . ${D}${MY_HTDOCSDIR}
	for doc in ${docs} LICENSE; do
		rm -f ${D}/${MY_HTDOCSDIR}/${doc}
	done

	webapp_configfile ${MY_HTDOCSDIR}/config.inc.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_src_install

	fperms 0640 ${MY_HTDOCSDIR}/config.inc.php
	fowners root:apache ${MY_HTDOCSDIR}/config.inc.php
	# bug #88831, make sure the create script is world-readable.
	fperms 0600 ${MY_SQLSCRIPTSDIR}/mysql/${PVR}_create.sql
}
