# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/midcom/midcom-1.3.2.ebuild,v 1.1 2004/09/22 11:11:17 rl03 Exp $

IUSE=""

DESCRIPTION="MidCOM provides a powerful framework for building Midgard websites from reusable and customizable building blocks, components"
HOMEPAGE="http://www.midgard-project.org/projects/midcom/"
SRC_URI="http://www.midgard-project.org/midcom-serveattachmentguid-b6937feb525bc041641cd4ed3784f3b6/${P}.tar.bz2"

KEYWORDS="~x86"

DEPEND="www-apps/aegir"

LICENSE="LGPL-2"
SLOT="0"

pkg_setup() {
	if [ `/etc/init.d/mysql status | cut -d: -f2 | cut -d' ' -f3` != 'started' ]; then
		die "Please /etc/init.d/mysql start and try again"
	fi
}

src_install() {
	dodoc README CHANGES INSTALL applications/midcom-template.CHANGES components/*.CHANGES
	dodir /usr/share/${P} /usr/share/${P}/applications /usr/share/${P}/components

	# fool repligard into installing into ${D}
	cp /etc/repligard.conf ${T}
	local BLOB=`grep 'blobdir=' ${T}/repligard.conf | cut -d\" -f2`
	sed -e "s|blobdir=.*$|blobdir=\"${D}/${BLOB}\"|" -i ${T}/repligard.conf

	# create the blobdir structure 
	dodir ${BLOB}
	cd ${D}/${BLOB} || die
	mkdir -p `perl -e '$dirs="0123456789ABCDEF"; @dirs = split(//, $dirs); foreach $l1 (@dirs) { foreach $l2 (@dirs) { print " $l1/$l2"; } }; '`

	cd ${S}

	repligard -a -c ${T}/repligard.conf -i midcom.xml || die "repligard failed"
	repligard -a -c ${T}/repligard.conf -i applications/midcom-template.xml || die "repligard failed"
	for file in components/*.xml; do
		 repligard -a -c ${T}/repligard.conf -i ${file} || die "repligard failed"
	done
}

pkg_postinst() {
	einfo "1. Make sure php_value register_globals is on (do it per vhost)."
	einfo "2. Change the host in MySQL host table"
	einfo "mysql midgard -umidgard -p -e \"UPDATE host SET name='my.host.name',port=80 WHERE name='localhost';\""
	einfo "3. Ensure that you have the correct VirtualHost entry in your midgard-data.conf"
	einfo "4. To get started, create a new website in Aegir CMS (from template: MidCOM site template),"
	einfo "log into that new site, use the provided initialization tool and"
	einfo "start building the site structure."
}
