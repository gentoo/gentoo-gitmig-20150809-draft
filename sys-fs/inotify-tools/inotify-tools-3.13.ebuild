# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/inotify-tools/inotify-tools-3.13.ebuild,v 1.3 2009/09/19 04:40:02 robbat2 Exp $

IUSE=""
DESCRIPTION="a set of command-line programs providing a simple interface to inotify"
HOMEPAGE="http://inotify-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~arm"
DEPEND="virtual/libc"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS AUTHORS
}
