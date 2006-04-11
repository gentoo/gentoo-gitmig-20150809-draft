# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.6h_p20060108-r2.ebuild,v 1.1 2006/04/11 01:08:53 ramereth Exp $

inherit eutils webapp depend.apache

# (patched versions)
MY_P=${P/_p*/}

DESCRIPTION="Cacti is a complete frontend to rrdtool"
HOMEPAGE="http://www.cacti.net/"
# patches 
UPSTREAM_PATCHES="fix_search_session_clear_issue
fix_sql_syntax_related_to_default_rra_id mysql_5x_strict
nth_percentile_empty_return_set_issue"
SRC_URI="http://www.cacti.net/downloads/${MY_P}.tar.gz"
for i in $UPSTREAM_PATCHES ; do
	SRC_URI="${SRC_URI} http://www.cacti.net/downloads/patches/${PV/_p*}/${i}.patch"
done

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="snmp"

DEPEND=""

want_apache

# alpha doesn't have lighttpd keyworded yet
RDEPEND="!alpha? ( !apache? ( !apache2? ( www-servers/lighttpd ) ) )
	snmp? ( net-analyzer/net-snmp )
	net-analyzer/rrdtool
	dev-db/mysql
	virtual/cron
	virtual/php
	virtual/httpd-php"

src_unpack() {
	unpack ${MY_P}.tar.gz ; mv ${MY_P} ${P}
	# patches
	for i in ${UPSTREAM_PATCHES} ; do
		EPATCH_OPTS="-p1 -d ${S} -N" epatch ${DISTDIR}/${i}.patch
	done ;
}

pkg_setup() {
	webapp_pkg_setup
	built_with_use virtual/php mysql || \
		die "php cli sapi must be compiled with USE=mysql"
	built_with_use virtual/httpd-php mysql || \
		die "php apache/cgi sapi must be compiled with USE=mysql"
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	webapp_src_preinst

	dodoc LICENSE
	rm LICENSE README

	dodoc docs/{CHANGELOG,CONTRIB,INSTALL,README,REQUIREMENTS,UPGRADE}
	rm -rf docs

	# Fix Security bug #129284 (remove on next release)
	rm lib/adodb/adodb-pager.inc.php

	edos2unix `find -type f -name '*.php'`

	dodir ${MY_HTDOCSDIR}
	cp -r . ${D}${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/rra
	webapp_serverowned ${MY_HTDOCSDIR}/log/cacti.log
	webapp_configfile ${MY_HTDOCSDIR}/include/config.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

