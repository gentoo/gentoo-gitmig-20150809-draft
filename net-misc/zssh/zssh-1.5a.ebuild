# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zssh/zssh-1.5a.ebuild,v 1.10 2005/04/20 22:09:25 mrness Exp $

inherit eutils

DESCRIPTION="A ssh wrapper enabling zmodem up/download in ssh"
HOMEPAGE="http://zssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/zssh/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="readline nls"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	 net-misc/openssh
	 net-dialup/lrzsz"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo-termcap.diff
	epatch ${FILESDIR}/${PF}-gentoo-include.diff
}

src_compile() {
	econf \
		`use_enable nls` \
		`use_enable readline` || die

	emake || die
}

src_install() {
	dobin zssh ztelnet
	doman zssh.1 ztelnet.1
	dodoc CHANGES FAQ README TODO
}
