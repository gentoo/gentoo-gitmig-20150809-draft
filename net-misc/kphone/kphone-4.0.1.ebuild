# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kphone/kphone-4.0.1.ebuild,v 1.3 2004/03/25 21:56:56 gustavoz Exp $

inherit kde

need-kde 3
LICENSE="GPL-2"
DESCRIPTION="a SIP user agent for Linux, with which you can initiate VoIP connections over the Internet."
SRC_URI="http://www.wirlab.net/kphone/${P}.tgz"
HOMEPAGE="http://www.wirlab.net/kphone/index.html"
KEYWORDS="~x86 ~amd64 ~sparc"

src_compile(){
# Fix for our kde location
myconf="$myconf --with-extra-libs=$KDEDIR/lib --datadir=${D}/usr/share --prefix=${D}/usr"
econf ${myconf}
emake
}
