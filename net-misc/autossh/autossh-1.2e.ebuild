# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/autossh/autossh-1.2e.ebuild,v 1.2 2004/02/11 15:43:06 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Automatically restart SSH sessions and tunnels"
HOMEPAGE="http://www.harding.motd.ca/autossh/"
LICENSE="BSD"
KEYWORDS="~x86 ~sparc ~alpha ~ia64"
SRC_URI="http://www.harding.motd.ca/autossh/${P}.tgz"
SLOT="0"

DEPEND="virtual/glibc sys-apps/sed"
RDEPEND="virtual/glibc net-misc/openssh"

src_unpack() {
	unpack ${A} && cd ${S}
	sed -i "s|CFLAGS=|CFLAGS=${CFLAGS}|g" Makefile.linux
}

src_compile() {
	emake -f Makefile.linux || die "make failed"
}

src_install() {
	dobin autossh
	dodoc CHANGES README autossh.host rscreen
	doman autossh.1
}

