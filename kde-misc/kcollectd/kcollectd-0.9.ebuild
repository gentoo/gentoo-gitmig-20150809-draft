# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcollectd/kcollectd-0.9.ebuild,v 1.9 2011/04/29 13:59:41 scarabeus Exp $

EAPI=4

inherit fdo-mime kde4-base flag-o-matic

DESCRIPTION="Simple KDE-based live data viewer for collectd"
HOMEPAGE="http://www.forwiss.uni-passau.de/~berberic/Linux/kcollectd.html"
SRC_URI="http://www.forwiss.uni-passau.de/~berberic/Linux/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/boost
	net-analyzer/rrdtool"
RDEPEND="${DEPEND}
	|| ( app-admin/collectd[collectd_plugins_rrdtool] app-admin/collectd[collectd_plugins_rrdcached] )"

PATCHES=( "${FILESDIR}/${P}-cflags.patch" )

src_configure() {
	append-flags -DBOOST_FILESYSTEM_VERSION=2
	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
