# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/webcomics-collector/webcomics-collector-0.7.3.ebuild,v 1.4 2005/09/30 15:57:34 metalgod Exp $

inherit distutils eutils

DESCRIPTION="python script for downloading webcomics"
HOMEPAGE="http://collector.skumleren.net/"
SRC_URI="http://collector.skumleren.net/releases/collector-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

S=${WORKDIR}/collector-${PV}

DOCS="UPGRADE"

pkg_setup() {
	if ! built_with_use dev-lang/python gdbm ; then
		eerror "You need to emerge python with USE=gdbm"
		die "re-emerge python with USE=gdbm"
	fi
}

pkg_postinst() {
	ewarn "If you are upgrading from an earlier version of Collector, please"
	ewarn "read UPGRADE. This new version will not be able to use your old"
	ewarn "archives if you do not follow the upgrade instructions!"
}
