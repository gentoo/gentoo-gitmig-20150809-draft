# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/zope-config/zope-config-0.6.ebuild,v 1.1 2008/11/16 15:11:23 tupone Exp $

DESCRIPTION="A Gentoo Zope multi-Instance configure tool"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64"
IUSE=""
DEPEND=""
RDEPEND="dev-util/dialog
		sys-apps/grep
		sys-apps/sed
		sys-apps/shadow
		dev-lang/python
		sys-apps/coreutils
		sys-apps/debianutils"

PDEPEND="net-zope/zope"

src_install() {
	# the script
	dosbin "${FILESDIR}"/${PV}/zope-config

	# config file
	insinto /etc
	doins "${FILESDIR}"/${PV}/zope-config.conf
	# ensure this directory exists
	keepdir /var/log/zope
}

pkg_postinst() {
	source "${FILESDIR}"/${PV}/zope-config.conf
	elog "Please note that new instances now log into ${EVENTLOGDIR}"
	elog "Please see the configuration file /etc/zope-config.conf"
}
