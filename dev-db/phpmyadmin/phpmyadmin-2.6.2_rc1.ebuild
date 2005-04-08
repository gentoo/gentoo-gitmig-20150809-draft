# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-2.6.2_rc1.ebuild,v 1.2 2005/04/08 17:23:41 hansmi Exp $

inherit eutils webapp

MY_PV=${PV/_p/-pl}
MY_PV=${MY_PV/_rc/-rc}
MY_P=phpMyAdmin-${MY_PV}
DESCRIPTION="Web-based administration for MySQL database in PHP"
HOMEPAGE="http://www.phpmyadmin.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~alpha ppc ~hppa ~sparc x86 ~amd64 ~mips"
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

	sed -e "s:\${MY_SQLSCRIPTSDIR}:${MY_SQLSCRIPTSDIR}:" \
		-e "s:\${PVR}:${PVR}:" \
		${FILESDIR}/postinstall-en.txt > ${WORKDIR}/postinstall-en.txt
}

src_compile() {
	einfo "Setting random user/password details for the controluser"

	local pmapass="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
	mv config.inc.php ${T}/config.inc.php
	sed -e "s/@pmapass@/${pmapass}/g" \
		${T}/config.inc.php > config.inc.php
	sed -e "s/@pmapass@/${pmapass}/g" \
		${FILESDIR}/mysql-setup.sql.in-2.5.6 > ${T}/mysql-setup.sql
}

src_install() {
	webapp_src_preinst

	local docs="ANNOUNCE.txt CREDITS Documentation.txt RELEASE-DATE-${PV} TODO ChangeLog LICENSE README"

	# install the SQL scripts available to us
	#
	# unfortunately, we do not have scripts to upgrade from older versions
	# these are things we need to add at a later date

	webapp_sqlscript mysql ${T}/mysql-setup.sql

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!

	dodoc ${docs}
	for doc in ${docs} INSTALL; do
		rm -f ${doc}
	done

	# Copy the app's main files

	einfo "Installing main files"
	cp -r . ${D}${MY_HTDOCSDIR}

	# Identify the configuration files that this app uses

	webapp_configfile ${MY_HTDOCSDIR}/config.inc.php

	# there are no files which need to be owned by the web server

	# add the post-installation instructions

	webapp_postinst_txt en ${WORKDIR}/postinstall-en.txt

	# all done
	#
	# now we let the eclass strut its stuff ;-)

	webapp_src_install
}
