# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/zope-config/zope-config-0.5.ebuild,v 1.3 2004/10/20 02:24:04 weeve Exp $

DESCRIPTION="A Gentoo Zope multi-Instance configure tool"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~alpha ~amd64"
IUSE=""
DEPEND=""
RDEPEND=">=dev-util/dialog-0.7
		sys-apps/grep
		sys-apps/sed
		sys-apps/shadow
		dev-lang/python
		sys-apps/coreutils"

PDEPEND=">=net-zope/zope-2.7.2-r2"

src_install() {
	# the script
	dosbin ${FILESDIR}/0.4/zope-config
	patch ${D}/usr/sbin/zope-config ${FILESDIR}/${PV}/${P}.patch

	# config file
	insinto /etc
	doins ${FILESDIR}/0.4/zope-config.conf
	# ensure this directory exists
	keepdir /var/log/zope
}

pkg_postinst() {
	source ${FILESDIR}/0.4/zope-config.conf
	einfo "Please note that new instances now log into ${EVENTLOGDIR}"
	einfo "Please see the configuration file /etc/zope-config.conf"
}
