# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/autossh/autossh-1.2e.ebuild,v 1.1 2004/01/27 15:26:15 agriffis Exp $

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
	unpack ${A} && cd ${S} || die
	patch -p0 -l < ${FILESDIR}/${P}-reuse.patch || die
	sed -i "s|CFLAGS=|CFLAGS=${CFLAGS}|g" Makefile.linux || die
}

src_compile() {
	emake -f Makefile.linux || die "make failed"
}

src_install() {
	dobin autossh
	dodoc CHANGES README autossh.host rscreen
	doman autossh.1
}

