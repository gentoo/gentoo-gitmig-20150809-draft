# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/townportal/townportal-0.5.ebuild,v 1.1 2004/09/22 11:28:42 rl03 Exp $

IUSE=""
SLOT="0"
MY_PN="TownPortal"

DESCRIPTION="TownPortal is a free portal system for villages and other local communities."
HOMEPAGE="http://www.midgard-project.org/projects/townportal/"
SRC_URI="http://www.midgard-project.org/midcom-serveattachmentguid-3b188b6b934daf3d1057d8cc08176b74/${MY_PN}-0.5.tar.bz2"
S=${WORKDIR}/${MY_PN}-${PV}

KEYWORDS="~x86"

DEPEND="www-apps/midgard"

LICENSE="GPL-2"

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
	repligard -a -c ${T}/repligard.conf -i TownPortal-Dependencies.xml.gz || die "repligard failed"
	repligard -a -c ${T}/repligard.conf -i TownPortal.xml.gz || die "repligard failed"
}

pkg_postinst() {
	einfo "1. Make sure php_value register_globals is on (do it per vhost)."
	einfo "2. Change the host in MySQL host table"
	einfo "mysql midgard -umidgard -p -e \"UPDATE host SET name='my.host.name',port=80 WHERE name='localhost';\""
	einfo "3. Ensure that you have the correct VirtualHost entry in your midgard-data.conf"
	einfo "4. Read http://www.midgard-project.org/projects/townportal/installation.html"
}
