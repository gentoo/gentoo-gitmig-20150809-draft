# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/vyqchat/vyqchat-0.1.1.ebuild,v 1.5 2004/03/20 03:34:33 mr_bones_ Exp $

DESCRIPTION="QT based Vypress Chat clone for X."
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE="arts"

DEPEND=">=x11-libs/qt-3.0
		arts? ( kde-base/arts )"

src_compile() {
	local myconf
	use arts && myconf="--with-arts"
	./configure  --host=${CHOST} \
		--prefix=/usr --infodir=/usr/share/info \
		--mandir=/usr/share/man --with-x \
		--with-Qt-dir=/usr/qt/3 ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc README THANKS NEWS
}
