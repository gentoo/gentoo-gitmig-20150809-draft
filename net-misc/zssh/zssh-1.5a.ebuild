# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zssh/zssh-1.5a.ebuild,v 1.8 2004/07/01 22:16:47 squinky86 Exp $

inherit eutils

IUSE="readline nls"

S=${WORKDIR}/${P}
DESCRIPTION="A ssh wrapper enabling zmodem up/download in ssh"
HOMEPAGE="http://zssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/zssh/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	 net-misc/openssh
	 net-misc/lrzsz"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo-termcap.diff
	epatch ${FILESDIR}/${PF}-gentoo-include.diff
}

src_compile() {
#	./configure	\
#		--prefix=/usr	\
#		--host=${CHOST}	\
	econf \
		`use_enable nls` \
		`use_enable readline` || die

	emake || die
}

src_install() {
	doman zssh.1
	doman ztelnet.1

	dobin zssh
	dobin ztelnet

	dodoc CHANGES FAQ README TODO
}

