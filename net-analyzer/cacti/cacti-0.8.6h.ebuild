# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.6h.ebuild,v 1.1 2006/01/04 16:26:57 ramereth Exp $

inherit eutils webapp

DESCRIPTION="Cacti is a complete frontend to rrdtool"
HOMEPAGE="http://www.cacti.net/"
# patches (none needed for new 0.8.6h)
#UPSTREAM_PATCHES=""
SRC_URI="http://www.cacti.net/downloads/${P}.tar.gz"
#for i in $UPSTREAM_PATCHES ; do
#	SRC_URI="${SRC_URI} http://www.cacti.net/downloads/patches/${PV}/${i}"
#done

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="snmp"

DEPEND=""

# TODO: RDEPEND Not just apache... but there's no virtual/webserver (yet)

RDEPEND="net-www/apache
	snmp? ( net-analyzer/net-snmp )
	net-analyzer/rrdtool
	dev-db/mysql
	virtual/cron
	virtual/php
	virtual/httpd-php"

src_unpack() {
	unpack ${P}.tar.gz
	# patches (none needed for new 0.8.6h)
	#for i in ${UPSTREAM_PATCHES} ; do
	#	EPATCH_OPTS="-p1 -d ${S} -N" epatch ${DISTDIR}/${i}
	#done ;
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

	edos2unix `find -type f -name '*.php'`

	dodir ${MY_HTDOCSDIR}
	cp -r . ${D}${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/include/config.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

