# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/fakeidentd/fakeidentd-2.2.ebuild,v 1.1 2004/09/20 00:17:10 vapier Exp $

inherit gcc

DESCRIPTION="A static, secure identd.  One source file only!"
HOMEPAGE="http://www.guru-group.fi/~too/sw/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	sed -i "s:identd.pid:${PN}.pid:" identd.c
}

src_compile() {
	$(gcc-getCC) identd.c -o ${PN} ${CFLAGS} || die
}

src_install() {
	dosbin ${PN} || die
	# Changelog in source is more current. Its only ~13kB anyway.
	dodoc identd.readme identd.c

	exeinto /etc/init.d ; newexe ${FILESDIR}/fakeidentd.rc fakeidentd
	insinto /etc/conf.d ; newins ${FILESDIR}/fakeidentd.confd fakeidentd
}
