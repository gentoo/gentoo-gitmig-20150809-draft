# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.6i-r1.ebuild,v 1.9 2007/06/26 02:20:27 mr_bones_ Exp $

inherit eutils webapp depend.apache depend.php

# Support for _p* in version.
MY_P=${P/_p*/}
# (patched versions)
HAS_PATCHES=1

DESCRIPTION="Cacti is a complete frontend to rrdtool"
HOMEPAGE="http://www.cacti.net/"
SRC_URI="http://www.cacti.net/downloads/${MY_P}.tar.gz"

# patches
if [ $HAS_PATCHES == 1 ] ; then
	UPSTREAM_PATCHES="poller_output_remainder
	dec06-vulnerability-poller-0.8.6i
	dec06-vulnerability-scripts-0.8.6i
	import_template_argument_space_removal"
	for i in $UPSTREAM_PATCHES ; do
		SRC_URI="${SRC_URI} http://www.cacti.net/downloads/patches/${PV/_p*}/${i}.patch"
	done
fi

LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ~hppa ppc ppc64 sparc x86"
IUSE="snmp"

DEPEND=""

want_apache
need_php_cli
need_php_httpd

RDEPEND="!apache2? ( www-servers/lighttpd )
	snmp? ( net-analyzer/net-snmp )
	net-analyzer/rrdtool
	virtual/mysql
	virtual/cron"

src_unpack() {
	if [ $HAS_PATCHES == 1 ] ; then
		unpack ${MY_P}.tar.gz
		[ ! ${MY_P} == ${P} ] && mv ${MY_P} ${P}
		# patches
		for i in ${UPSTREAM_PATCHES} ; do
			EPATCH_OPTS="-p1 -d ${S} -N" epatch "${DISTDIR}"/${i}.patch
		done ;
	else
		unpack ${MY_P}.tar.gz
	fi
}

pkg_setup() {
	webapp_pkg_setup
	has_php
	if [ $PHP_VERSION = 5 ] ; then
		require_php_with_use cli mysql xml
	elif [ $PHP_VERSION = 4 ] ; then
		require_php_with_use cli mysql xml expat
	fi
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
	cp -r . "${D}"${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/rra
	webapp_serverowned ${MY_HTDOCSDIR}/log/cacti.log
	webapp_configfile ${MY_HTDOCSDIR}/include/config.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}

