# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/vyqchat/vyqchat-0.2.3.ebuild,v 1.2 2004/03/19 12:54:25 zul Exp $

DESCRIPTION="QT based Vypress Chat clone for X."
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="arts"

DEPEND=">=xll-libs/qt-3.0
		arts? ( kde-base/arts )"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_compile() {
	local myconf

	epatch ${FILESDIR}/vyqchat_packet_id.patch

	use arts && myconf="--with-arts"
	./configure  --host=${CHOST} \
		--prefix=/usr --infodir=/usr/share/info \
		--mandir=/usr/share/man --with-x \
		--with-Qt-dir=/usr/qt/3 ${myconf} || die "./configure failed"
	make || die
}

src_install() {
	einstall || die
	dodoc README THANKS NEWS
}
