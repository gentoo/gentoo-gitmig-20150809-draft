# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kphone/kphone-4.0.3.ebuild,v 1.2 2004/07/25 16:18:47 carlo Exp $

inherit eutils kde

DESCRIPTION="A SIP user agent for Linux, with which you can initiate VoIP connections over the Internet."
HOMEPAGE="http://www.wirlab.net/kphone/index.html"
SRC_URI="http://www.wirlab.net/kphone/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

S=${WORKDIR}/kphone

need-kde 3

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.diff
}
src_compile(){
	# Fix for our kde location
	myconf="$myconf --with-extra-libs=$KDEDIR/lib --prefix=/usr"
	econf ${myconf} || die "econf failed"
	emake
}

