# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssistats/irssistats-0.6.ebuild,v 1.5 2004/07/01 22:22:21 eradicator Exp $

DESCRIPTION="Generates HTML IRC stats based on irssi logs."
HOMEPAGE="http://royale.zerezo.com/irssistats/"
SRC_URI="http://royale.zerezo.com/irssistats/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/libc
		>=sys-apps/sed-4"

RDEPEND=""

src_compile() {
	sed -i \
		-e "s:PRE = /usr/local:PRE = ${D}/usr:" Makefile
	emake
}

src_install() {
	make install
}


