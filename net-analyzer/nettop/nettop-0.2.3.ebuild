# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nettop/nettop-0.2.3.ebuild,v 1.1 2003/09/14 17:58:16 zul Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="top like program for network activity"
SRC_URI="http://srparish.net/scripts/${P}.tar.gz"
HOMEPAGE="http://srparish.net/software/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

DEPEND="sys-libs/slang
	    net-libs/libpcap"


src_compile() {
	local myconf
	myconf="--prefix=/usr"
	./configure ${myconf} || die
	emake
}

src_install() {
	dosbin nettop
	dodoc ChangeLog README THANKS
}
