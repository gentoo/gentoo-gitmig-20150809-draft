# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nettop/nettop-0.2.3.ebuild,v 1.11 2005/05/10 16:04:59 ticho Exp $

inherit eutils

IUSE=""

DESCRIPTION="top like program for network activity"
SRC_URI="http://srparish.net/scripts/${P}.tar.gz"
HOMEPAGE="http://srparish.net/software/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc ppc ~amd64"

DEPEND="sys-libs/slang
	    virtual/libpcap"


src_compile() {
	epatch ${FILESDIR}/nettop.c.patch

	local myconf
	myconf="--prefix=/usr"
	./configure ${myconf} || die
	emake || die
}

src_install() {
	dosbin nettop || die
	dodoc ChangeLog README THANKS
}
