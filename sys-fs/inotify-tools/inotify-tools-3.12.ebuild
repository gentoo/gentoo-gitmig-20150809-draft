# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/inotify-tools/inotify-tools-3.12.ebuild,v 1.2 2007/11/24 09:25:24 drac Exp $

DESCRIPTION="a set of command-line programs providing a simple interface to inotify"
HOMEPAGE="http://inotify-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
DEPEND="virtual/libc"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS AUTHORS
}
