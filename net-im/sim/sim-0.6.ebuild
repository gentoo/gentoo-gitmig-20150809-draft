# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.6.ebuild,v 1.3 2003/09/05 23:58:58 msterret Exp $
inherit kde-base

LICENSE="GPL-2"
DESCRIPTION="An ICQ v8 Client. Supports File Transfer, Chat, Server-Side Contactlist, ..."
SRC_URI="http://sim.shutoff.spb.ru/${P}.tar.gz"
HOMEPAGE="http://sim.shutoff.spb.ru/"
KEYWORDS="x86"

#if [ "`use kde`" ]; then
#    need-qt 3
#    myconf="$myconf --enable-kde"
#else
	need-kde 3
#    myconf="$myconf --disable-kde"
#fi
#
#src_compile() {
#
#    kde_src_compile myconf
#    myconf="$myconf --prefix=/usr"
#    kde_src_compile configure make
#
#}
