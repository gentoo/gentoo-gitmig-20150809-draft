# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssistats/irssistats-0.62.ebuild,v 1.2 2004/06/24 23:06:37 agriffis Exp $

inherit gcc

DESCRIPTION="Generates HTML IRC stats based on irssi logs."
HOMEPAGE="http://royale.zerezo.com/irssistats/"
SRC_URI="http://royale.zerezo.com/irssistats/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=""

src_compile() {
	$(gcc-getCC) -o irssistats ${CFLAGS} irssistats.c
}

src_install() {
	make \
		PRE=${D}/usr \
		DOC=${D}/usr/share/doc/${PF} \
		install \
		|| die "make install failed"
}
