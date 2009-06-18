# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lsyncd/lsyncd-1.26.ebuild,v 1.1 2009/06/18 12:02:54 deathwing00 Exp $


DESCRIPTION="Live Syncing (Mirror) Daemon"
HOMEPAGE="http://code.google.com/p/lsyncd/"
SRC_URI="http://lsyncd.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS NEWS README TODO ChangeLog || die
}

