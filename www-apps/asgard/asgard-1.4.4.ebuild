# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/asgard/asgard-1.4.4.ebuild,v 1.1 2004/09/22 11:00:51 rl03 Exp $

DESCRIPTION="Asgard is an admin interface for the open source content mangement framework Midgard"
HOMEPAGE="http://asgard.midgard-project.org/"
SRC_URI="http://asgard.midgard-project.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=www-apps/midgard-lib-${PV}
	>=www-apache/mod_midgard-preparse-${PV}
	>=www-apps/midgard-php4-${PV}
	>=www-apps/midgard-data
"

pkg_setup() {
	if [ `/etc/init.d/mysql status | cut -d: -f2 | cut -d' ' -f3` != 'started' ]; then
		die "Please /etc/init.d/mysql start and try again"
	fi
}


src_install() {
	dodoc INSTALL README
	# fool repligard into installing into ${D}
	cp /etc/repligard.conf ${T}
	local BLOB=`grep 'blobdir=' ${T}/repligard.conf | cut -d\" -f2`
	sed -e "s|blobdir=.*$|blobdir=\"${D}/${BLOB}\"|" -i ${T}/repligard.conf

	# create the blobdir structure
	dodir ${BLOB}
	cd ${D}/${BLOB} || die
	mkdir -p `perl -e '$dirs="0123456789ABCDEF"; @dirs = split(//, $dirs); foreach $l1 (@dirs) { foreach $l2 (@dirs) { print " $l1/$l2"; } }; '`

	cd ${S}
	repligard -a -c ${T}/repligard.conf -i Asgard.xml.gz || die "repligard installation failed"
}

pkg_postinst() {
	einfo "1. Configure repligard to log in on SG0 by editing /etc/repligard.conf file"
	einfo "(you might need to set login username/password to asgard/password)"
	einfo "2. Then, edit the host table, if Asgard wasn't installed before"
	einfo "mysql -uroot -p<password> -e \"UPDATE host SET name='www.myhost.com' WHERE name='localhost';\" midgard"
	einfo "where www.myhost.com has to be replaced by your host name."
}
