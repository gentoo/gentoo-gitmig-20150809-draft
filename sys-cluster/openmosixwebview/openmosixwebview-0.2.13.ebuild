# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmosixwebview/openmosixwebview-0.2.13.ebuild,v 1.7 2004/07/15 03:06:00 agriffis Exp $

DESCRIPTION="Produces web charts for monitoring an openMosix cluster"
SRC_URI="http://laurel.datsi.fi.upm.es/~rpons/openmosix/download/openmosixwebview-${PV}.tar.gz"
HOMEPAGE="http://laurel.datsi.fi.upm.es/~rpons/openmosix/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="apache2"

DEPEND=">=sys-cluster/openmosix-user-0.3.5
	>=net-www/apache-2
	>=dev-php/mod_php-4"

src_install() {
	use apache2 || insinto /etc/apache/conf/addon-modules
	use apache2 || newins  ${FILESDIR}/apache.conf openmosixwebview.conf
	use apache2 && insinto /etc/apache2/conf/modules.d
	use apache2 && newins ${FILESDIR}/apache.conf 70_openmosixwebview.conf

	dodir /var/www/openmosixwebview
	cp * ${D}/var/www/openmosixwebview
}

pkg_postinst() {
	einfo
	einfo "Make sure to start openmosixcollector by running"
	einfo "\"/etc/init.d/openmosixcollector start\""
	einfo "or by adding it to your default runlevel with"
	einfo "\"rc-update add openmosixcollector default\""
	einfo
}
