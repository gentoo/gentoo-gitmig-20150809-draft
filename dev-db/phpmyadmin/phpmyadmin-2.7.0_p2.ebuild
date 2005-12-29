# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-2.7.0_p2.ebuild,v 1.1 2005/12/29 15:14:00 rl03 Exp $

inherit eutils webapp

MY_PV=${PV/_p/-pl}
MY_P=phpMyAdmin-${MY_PV}
DESCRIPTION="Web-based administration for MySQL database in PHP"
HOMEPAGE="http://www.phpmyadmin.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""
DEPEND=">=dev-db/mysql-3.23.32 <dev-db/mysql-5.1
	virtual/httpd-php
	sys-apps/findutils
	!<=dev-db/phpmyadmin-2.5.6"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/config.default.php-2.7.0.patch

	# Remove .cvs* files and CVS directories
	find ${S} -name .cvs\* -or \( -type d -name CVS -prune \) | xargs rm -rf
}

src_compile() {
	einfo "Setting random user/password details for the controluser"

	local pmapass="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
	sed -e "s/@pmapass@/${pmapass}/g" -i config.default.php
	sed -e "s/@pmapass@/${pmapass}/g" \
		${FILESDIR}/mysql-setup.sql.in-2.5.6 > ${T}/mysql-setup.sql
}

src_install() {
	webapp_src_preinst

	local docs="CREDITS Documentation.txt INSTALL README RELEASE-DATE-${MY_PV} TODO ChangeLog"

	# install the SQL scripts available to us
	#
	# unfortunately, we do not have scripts to upgrade from older versions
	# these are things we need to add at a later date

	webapp_sqlscript mysql ${T}/mysql-setup.sql

	dodoc ${docs} ChangeLog
	dohtml Documentation.html

	# Copy the app's main files

	einfo "Installing main files"
	cp -r . ${D}${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/config.default.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig-2.7
	webapp_src_install

	fperms 0640 ${MY_HTDOCSDIR}/config.default.php
	fowners root:apache ${MY_HTDOCSDIR}/config.default.php
	# bug #88831, make sure the create script is world-readable.
	fperms 0600 ${MY_SQLSCRIPTSDIR}/mysql/${PVR}_create.sql
}
