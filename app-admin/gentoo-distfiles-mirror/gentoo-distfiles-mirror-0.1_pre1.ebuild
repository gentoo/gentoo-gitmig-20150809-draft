# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoo-distfiles-mirror/gentoo-distfiles-mirror-0.1_pre1.ebuild,v 1.1 2003/11/18 01:27:39 tantive Exp $

S=${WORKDIR}/gentoo-distfiles-mirror-${PV/_pre1}
DESCRIPTION="Ebuild for setting up a Gentoo distfiles mirror"
HOMEPAGE="http://www.gentoo.org/doc/en/source_mirrors.xml"
IUSE=""

DEPEND="virtual/glibc
	>=net-www/apache-2.0.47"
RDEPEND=">=net-www/apache-2.0.47"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-*"

src_install() {
	insinto /var/www/distfiles
	newins ${FILESDIR}/${PV/_pre1}/portage-incremirror portage-incremirror
	chown apache:apache ${D}/var/www/distfiles
	chmod 0755 ${D}/var/www/distfiles
	chown apache:apache ${D}/var/www/distfiles/portage-incremirror
	chmod 0744 ${D}/var/www/distfiles/portage-incremirror
	insinto /etc/apache2/conf/modules.d
	newins ${FILESDIR}/${PV/_pre1}/apache.addon-module 65_gentoo-distfiles-mirror.conf
	touch ${D}/var/www/distfiles/.queue
	chown apache:apache ${D}/var/www/distfiles/.queue
	chmod 0644 ${D}/var/www/distfiles/.queue
}
