# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.8.2-r2.ebuild,v 1.1 2003/06/30 11:07:37 aliz Exp $

IUSE="ssl kde"
[ -n "`use kde`" ] && inherit kde-base eutils
[ -n "`use kde`" ] || inherit base kde-functions eutils

LICENSE="GPL-2"
DESCRIPTION="An ICQ v8 Client. Supports File Transfer, Chat, Server-Side Contactlist, ..."
SRC_URI="mirror://sourceforge/sim-icq/${P}.tar.gz"
HOMEPAGE="http://sim-icq.sourceforge.net"
KEYWORDS="~x86 ~ppc"
SLOT="0"

newdepend "ssl? ( dev-libs/openssl )"
DEPEND="$DEPEND sys-devel/flex"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-nostl.diff
	epatch ${FILESDIR}/${PV}-patches
}

src_compile() {
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

	need-automake 1.5
	need-autoconf 2.5

	make -f admin/Makefile.common

	myconf="$myconf --without-gkrellm_plugin"
	[ -n "`use kde`" ] && kde_src_compile myconf 
	myconf="$myconf --prefix=/usr"

	econf $myconf --without-gkrellm || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc TODO README ChangeLog COPYING AUTHORS
}
