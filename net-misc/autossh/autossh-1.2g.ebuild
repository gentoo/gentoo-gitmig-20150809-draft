# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/autossh/autossh-1.2g.ebuild,v 1.6 2010/08/03 18:18:40 xarthisius Exp $

inherit toolchain-funcs

DESCRIPTION="Automatically restart SSH sessions and tunnels"
HOMEPAGE="http://www.harding.motd.ca/autossh/"
LICENSE="BSD"
KEYWORDS="x86 ~sparc alpha ia64 amd64 ~ppc"
SRC_URI="http://www.harding.motd.ca/autossh/${P}.tgz"
SLOT="0"
IUSE=""

DEPEND="sys-apps/sed"
RDEPEND="net-misc/openssh"

src_unpack() {
	unpack ${A} && cd "${S}"
	sed -i -e "s|CFLAGS=|CFLAGS=${CFLAGS}|g" \
		-e "s:\$(CC):& \$(LDFLAGS):" Makefile.linux || die
}

src_compile() {
	tc-export CC
	emake -f Makefile.linux || die "make failed"
}

src_install() {
	dobin autossh
	dodoc CHANGES README autossh.host rscreen
	doman autossh.1
}
