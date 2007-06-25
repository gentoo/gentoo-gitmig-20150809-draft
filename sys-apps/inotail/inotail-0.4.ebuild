# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/inotail/inotail-0.4.ebuild,v 1.1 2007/06/25 00:04:50 angelos Exp $

DESCRIPTION="tail replacement using inotify"
HOMEPAGE="http://distanz.ch/inotail/"
SRC_URI="http://distanz.ch/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	make prefix="${D}usr" install || die "install failed"
	dodoc changelog README
}
