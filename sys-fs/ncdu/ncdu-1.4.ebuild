# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ncdu/ncdu-1.4.ebuild,v 1.1 2008/11/29 21:13:11 wschlich Exp $

IUSE=""
DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="http://dev.yorhel.nl/ncdu/"
SRC_URI="http://dev.yorhel.nl/download/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
DEPEND="sys-libs/ncurses"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README NEWS ChangeLog
}
