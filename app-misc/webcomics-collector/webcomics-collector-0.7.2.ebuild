# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/webcomics-collector/webcomics-collector-0.7.2.ebuild,v 1.2 2004/11/22 03:19:32 vapier Exp $

inherit distutils

DESCRIPTION="python script for downloading webcomics"
HOMEPAGE="http://collector.skumleren.net/"
SRC_URI="http://collector.skumleren.net/releases/collector-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

S=${WORKDIR}/collector-${PV}

DOCS="UPGRADE"

pkg_postinst() {
	ewarn "If you are upgrading from an earlier version of Collector, please"
	ewarn "read UPGRADE. This new version will not be able to use your old"
	ewarn "archives if you do not follow the upgrade instructions!"
}
