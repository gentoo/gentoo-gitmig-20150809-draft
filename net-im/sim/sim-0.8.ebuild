# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.8.ebuild,v 1.4 2003/09/05 23:58:58 msterret Exp $

IUSE="ssl kde"
[ -n "`use kde`" ] && inherit kde-base
[ -n "`use kde`" ] || inherit base kde-functions

LICENSE="GPL-2"
DESCRIPTION="An ICQ v8 Client. Supports File Transfer, Chat, Server-Side Contactlist, ..."
SRC_URI="http://sim.shutoff.spb.ru/${P}.tar.gz"
HOMEPAGE="http://sim.shutoff.spb.ru/"
KEYWORDS="x86"
SLOT="0"

newdepend "ssl? ( dev-libs/openssl )"
DEPEND="$DEPEND sys-devel/flex"

if [ -n "`use ssl`" ]; then
	myconf="$myconf --enable-openssl"
else
	myconf="$myconf --disable-openssl"
fi

if [ -n "`use kde`" ]; then
	need-kde 3
	myconf="$myconf --enable-kde"
else
	need-qt 3
	myconf="$myconf --disable-kde"
fi

PATCHES="$FILESDIR/$P-nostl.diff"

src_compile() {

	[ -n "`use kde`" ] && kde_src_compile myconf
	myconf="$myconf --prefix=/usr"

	cd $S
	./configure $myconf || die
	emake || die
}

src_install() {
	cd $S
	make DESTDIR=$D install
	dodoc TODO README ChangeLog COPYING AUTHORS
}
