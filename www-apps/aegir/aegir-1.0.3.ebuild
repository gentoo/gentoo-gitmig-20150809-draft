# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/aegir/aegir-1.0.3.ebuild,v 1.1 2004/09/22 11:07:04 rl03 Exp $

MY_P=${P/a/A}
S=${WORKDIR}/${MY_P}

IUSE=""

DESCRIPTION="Aegir is a versatile and user-friendly Web Content Management System that uses the Midgard framework"
HOMEPAGE="http://www.midgard-project.org/projects/aegir/"
SRC_URI="http://www.midgard-project.org/midcom-serveattachmentguid-7be8cd5cb3ecfa6b1f11f3b03d40dd13/${MY_P}.tar.bz2"

KEYWORDS="~x86"

DEPEND="www-apps/midgard-data
	www-apache/mod_midgard-preparse"
RDEPEND="${DEPEND}
	app-admin/webalizer"

LICENSE="LGPL-2"
SLOT="0"

pkg_setup() {
	if [ `/etc/init.d/mysql status | cut -d: -f2 | cut -d' ' -f3` != 'started' ]; then
		die "Please /etc/init.d/mysql start and try again"
	fi
}

src_install() {
	# fool repligard into installing into ${D}
	cp /etc/repligard.conf ${T}
	local BLOB=`grep 'blobdir=' ${T}/repligard.conf | cut -d\" -f2`
	sed -e "s|blobdir=.*$|blobdir=\"${D}/${BLOB}\"|" -i ${T}/repligard.conf

	# create the blobdir structure
	dodir ${BLOB}
	cd ${D}/${BLOB} || die
	mkdir -p `perl -e '$dirs="0123456789ABCDEF"; @dirs = split(//, $dirs); foreach $l1 (@dirs) { foreach $l2 (@dirs) { print " $l1/$l2"; } }; '`

	cd ${S}
	for file in Aegir* PHP*; do
		 repligard -a -c ${T}/repligard.conf -i ${file} || die "repligard failed"
	done

	dodoc README
}

pkg_postinst() {
	einfo "1. Make sure php_value register_globals is on (do it per vhost)."
	einfo "2. Change the Aegir CMS host in MySQL host table"
	einfo "mysql midgard -umidgard -p -e \"UPDATE host SET name='my.host.name',port=80 WHERE name='localhost';\""
	einfo "3. Ensure that you have the correct VirtualHost entry in your midgard-data.conf"
	einfo "4. Open your browser and go to http://hostname.mydomain.com/aegir"
	einfo "Company: System Administrator, Username: admin, Password: password"
	einfo "CHANGE THE DEFAULT PASSWORD!"
	einfo "5. Edit /etc/repligard.conf and set the password to whatever you"
	einfo "changed it to"
	einfo "6. The Website stats package requires a webalizer installation"
	einfo "that will generate its log analysis files to"
	einfo "/var/www/webalizer/www.sitename.com/ where www.sitename.com is that"
	einfo "site's hostname."
	einfo "ATTENTION: If images are broken, you need to create an attachment host"
	einfo "Login to /admin, and modify the existing /attachment/0/ host!"
}
