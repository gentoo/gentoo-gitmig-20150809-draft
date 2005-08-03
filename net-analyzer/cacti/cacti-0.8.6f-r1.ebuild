# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.6f-r1.ebuild,v 1.2 2005/08/03 13:33:29 gustavoz Exp $

inherit eutils webapp

DESCRIPTION="Cacti is a complete frontend to rrdtool"
HOMEPAGE="http://www.cacti.net/"
# patches as of end of July
UPSTREAM_PATCHES="html_mouseover_title.patch multi_field_output_script_server.patch old_net_snmp_command_options.patch poller_invalid_data_sources.patch script_server_buffer_size.patch unix_syslog_compatibility.patch graph_view_preview_mode_filter.patch poller_reindex_cache_orphans.patch safari_zoom.patch ldap_copy_user_problem.patch script_server_file_header.patch"
SRC_URI="http://www.cacti.net/downloads/${P}.tar.gz"
for i in $UPSTREAM_PATCHES ; do
	SRC_URI="${SRC_URI} http://www.cacti.net/downloads/patches/${PV}/${i}"
done

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc sparc x86"
IUSE="snmp"

DEPEND=""

# TODO: RDEPEND Not just apache... but there's no virtual/webserver (yet)

RDEPEND="net-www/apache
	snmp? ( net-analyzer/net-snmp )
	net-analyzer/rrdtool
	dev-db/mysql
	virtual/cron
	dev-php/php
	dev-php/mod_php"

src_unpack() {
	unpack ${P}.tar.gz
	for i in ${UPSTREAM_PATCHES} ; do
		EPATCH_OPTS="-p1 -d ${S} -N" epatch ${DISTDIR}/${i}
	done ;
}

pkg_setup() {
	webapp_pkg_setup
	built_with_use dev-php/php mysql || \
		die "dev-php/php must be compiled with USE=mysql"
	built_with_use dev-php/mod_php mysql || \
		die "dev-php/mod_php must be compiled with USE=mysql"
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

	edos2unix `find -type f -name '*.php'`

	dodir ${MY_HTDOCSDIR}
	cp -r . ${D}${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/include/config.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

