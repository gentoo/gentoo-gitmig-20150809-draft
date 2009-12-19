# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.7e-r1.ebuild,v 1.7 2009/12/19 15:18:52 jer Exp $

inherit eutils webapp depend.php

# Support for _p* in version.
MY_P=${P/_p*/}
HAS_PATCHES=1

DESCRIPTION="Cacti is a complete frontend to rrdtool"
HOMEPAGE="http://www.cacti.net/"
SRC_URI="http://www.cacti.net/downloads/${MY_P}.tar.gz"

# patches
if [ "${HAS_PATCHES}" == "1" ] ; then
	UPSTREAM_PATCHES="cli_add_graph
		snmp_invalid_response
		template_duplication
		fix_icmp_on_windows_iis_servers
		cross_site_fix"
	for i in ${UPSTREAM_PATCHES} ; do
		SRC_URI="${SRC_URI} http://www.cacti.net/downloads/patches/${PV/_p*}/${i}.patch"
	done
fi

LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ~ppc ppc64 sparc x86"
IUSE="snmp doc"

DEPEND=""

need_php_cli
need_httpd_cgi
need_php_httpd

RDEPEND="snmp? ( >=net-analyzer/net-snmp-5.1.2 )
	net-analyzer/rrdtool
	dev-php/adodb
	virtual/mysql
	virtual/cron"

src_unpack() {
	if [ "${HAS_PATCHES}" == "1" ] ; then
		unpack ${MY_P}.tar.gz
		[ ! ${MY_P} == ${P} ] && mv ${MY_P} ${P}
		# patches
		for i in ${UPSTREAM_PATCHES} ; do
			EPATCH_OPTS="-p1 -d ${S} -N" epatch "${DISTDIR}"/${i}.patch
		done ;
	else
		unpack ${MY_P}.tar.gz
	fi

	sed -i -e \
		's:$config\["library_path"\] . "/adodb/adodb.inc.php":"adodb/adodb.inc.php":' \
		"${S}"/include/global.php

	rm -rf lib/adodb # don't use bundled adodb
}

pkg_setup() {
	webapp_pkg_setup
	has_php
	require_php_with_use cli mysql xml session pcre sockets
}

src_compile() { :; }

src_install() {
	webapp_src_preinst

	rm LICENSE README
	dodoc docs/{CHANGELOG,CONTRIB,README,txt/manual.txt} || die
	use doc && dohtml -r docs/html/
	rm -rf docs

	edos2unix `find -type f -name '*.php'`

	dodir ${MY_HTDOCSDIR}
	cp -r . "${D}"${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/rra
	webapp_serverowned ${MY_HTDOCSDIR}/log/cacti.log
	webapp_configfile ${MY_HTDOCSDIR}/include/config.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
