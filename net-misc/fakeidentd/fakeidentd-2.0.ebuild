# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/fakeidentd/fakeidentd-2.0.ebuild,v 1.1 2003/06/17 13:37:59 vapier Exp $

DESCRIPTION="A static, secure identd.  One source file only!"
HOMEPAGE="http://www.guru-group.fi/~too/sw/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc"

S=${WORKDIR}

src_compile() {
	cp identd.c{,.old}
	sed -e "s:identd.pid:${PN}.pid:" \
		identd.c.old > identd.c
	gcc identd.c -o ${PN} ${CFLAGS} || die
}

src_install() {
	dosbin ${PN}
	# Changelog in source is more current. Its only ~13kB anyway.
	dodoc identd.readme identd.c
	
	exeinto /etc/init.d ; newexe ${FILESDIR}/fakeidentd.rc fakeidentd
	insinto /etc/conf.d ; newins ${FILESDIR}/fakeidentd.confd fakeidentd
}
