# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/openpsa/openpsa-1.9.0.ebuild,v 1.1 2004/09/22 11:25:23 rl03 Exp $

DESCRIPTION="OpenPSA is a Free, Web-based Management Software Package for Consultancies and Service organizations"
HOMEPAGE="http://www.openpsa.org/"
SRC_URI="http://www.openpsa.org/midcom-serveattachmentguid-e3aca527399cef0148c0829ef6111efa/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="www-apps/midgard"

pkg_setup() {
	if [ `/etc/init.d/mysql status | cut -d: -f2 | cut -d' ' -f3` != 'started' ]; then
		die "Please /etc/init.d/mysql start and try again"
	fi
}

src_install() {
	dodoc AUTHORS README supportmda.pl

	# fool repligard into installing into ${D}
	cp /etc/repligard.conf ${T}
	local BLOB=`grep 'blobdir=' ${T}/repligard.conf | cut -d\" -f2`
	sed -e "s|blobdir=.*$|blobdir=\"${D}/${BLOB}\"|" -i ${T}/repligard.conf

	# create the blobdir structure 
	dodir ${BLOB}
	cd ${D}/${BLOB} || die
	mkdir -p `perl -e '$dirs="0123456789ABCDEF"; @dirs = split(//, $dirs); foreach $l1 (@dirs) { foreach $l2 (@dirs) { print " $l1/$l2"; } }; '`

	cd ${S}
	repligard -a -c ${T}/repligard.conf -i openpsa.xml.gz || die "repligard failed"
}

pkg_postinst() {
	einfo "1. Then, edit the host table"
	einfo "mysql -uroot -p<password> -e \"UPDATE host SET name='www.myhost.com' WHERE name='localhost';\" midgard"
	einfo "where www.myhost.com has to be replaced by your host name."
	einfo "2. Then go to http://YOURHOST/openpsa_manager/"
}
