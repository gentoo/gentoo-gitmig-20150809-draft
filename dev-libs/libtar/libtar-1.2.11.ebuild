# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtar/libtar-1.2.11.ebuild,v 1.1 2004/10/10 07:47:52 vapier Exp $

DESCRIPTION="C library for manipulating POSIX tar files"
HOMEPAGE="http://www.feep.net/libtar/"
SRC_URI="ftp://ftp.feep.net/pub/software/libtar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/zlib"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog README TODO
}
