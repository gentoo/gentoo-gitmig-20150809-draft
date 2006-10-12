# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nbaudit/nbaudit-1.0.ebuild,v 1.19 2006/10/12 22:44:10 wormo Exp $

inherit eutils

# It is officially called nat10 but the name conflicts with other projects
# so I'm following the *BSDs suggestion of calling it nbaudit

MY_P=nat10
S=${WORKDIR}/${MY_P}
DESCRIPTION="NetBIOS file sharing services scanner (nat10)"
SRC_URI="http://www.tux.org/pub/security/secnet/tools/nat10/${MY_P}.tgz"
HOMEPAGE="http://www.tux.org/pub/security/secnet/tools/nat10/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	# NOTE: DO NOT SET CFLAGS OR THE PROGRAM WILL SEGFAULT
	make all || die "make failed"
}

src_install () {
	newbin nat nbaudit
	newman nat.1 nbaudit.1
	dodoc README COPYING
}
