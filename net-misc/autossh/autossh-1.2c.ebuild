# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/autossh/autossh-1.2c.ebuild,v 1.7 2004/07/15 02:39:08 agriffis Exp $

IUSE=""
DESCRIPTION="Automatically restart SSH sessions and tunnels"
HOMEPAGE="http://www.harding.motd.ca/autossh/"
LICENSE="BSD"
KEYWORDS="x86"
SRC_URI="http://www.harding.motd.ca/autossh/${P}.tgz"
SLOT="0"

DEPEND="virtual/libc
	sys-apps/sed"
RDEPEND="virtual/libc
	net-misc/openssh"

src_unpack() {
	unpack ${A}
	cd ${S}

	mv Makefile.linux Makefile.linux.orig
	sed "s/CFLAGS=/CFLAGS=${CFLAGS}/g" Makefile.linux.orig >Makefile.linux
}

src_compile() {
	emake -f Makefile.linux || die "make failed"
}

src_install() {
	dobin autossh
	dodoc CHANGES README autossh.host rscreen
	doman autossh.1
}
