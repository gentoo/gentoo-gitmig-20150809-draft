# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kphone/kphone-4.0.2.ebuild,v 1.5 2004/04/26 12:35:15 agriffis Exp $

inherit kde
need-kde 3

DESCRIPTION="a SIP user agent for Linux, with which you can initiate VoIP connections over the Internet."
SRC_URI="http://www.wirlab.net/kphone/${P}.tar.gz"
HOMEPAGE="http://www.wirlab.net/kphone/index.html"

KEYWORDS="~x86 ~amd64 sparc ~ppc"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

S=${WORKDIR}/kphone
src_compile(){
	# Fix for our kde location
	myconf="$myconf --with-extra-libs=$KDEDIR/lib --datadir=${D}/usr/share --prefix=${D}/usr"
	econf ${myconf} || die "econf failed"
	emake
}

