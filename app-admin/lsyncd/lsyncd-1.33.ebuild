# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lsyncd/lsyncd-1.33.ebuild,v 1.1 2010/06/10 22:00:58 spatz Exp $

EAPI=2

DESCRIPTION="Live Syncing (Mirror) Daemon"
HOMEPAGE="http://code.google.com/p/lsyncd/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-misc/rsync"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS NEWS README TODO ChangeLog || die
}
