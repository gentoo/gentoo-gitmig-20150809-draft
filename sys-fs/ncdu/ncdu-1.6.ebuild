# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ncdu/ncdu-1.6.ebuild,v 1.5 2010/05/24 15:00:06 armin76 Exp $

IUSE=""
DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="http://dev.yorhel.nl/ncdu/"
SRC_URI="http://dev.yorhel.nl/download/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README NEWS ChangeLog
}
