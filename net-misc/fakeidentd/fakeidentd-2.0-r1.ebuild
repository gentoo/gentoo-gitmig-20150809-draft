# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/fakeidentd/fakeidentd-2.0-r1.ebuild,v 1.3 2003/12/17 04:30:56 brad_mssw Exp $

inherit gcc

DESCRIPTION="A static, secure identd.  One source file only!"
HOMEPAGE="http://www.guru-group.fi/~too/sw/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ppc64"

DEPEND="virtual/glibc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-memset.patch
	sed -i "s:identd.pid:${PN}.pid:" identd.c
}

src_compile() {
	$(gcc-getCC) identd.c -o ${PN} ${CFLAGS} || die
}

src_install() {
	dosbin ${PN}
	# Changelog in source is more current. Its only ~13kB anyway.
	dodoc identd.readme identd.c

	exeinto /etc/init.d ; newexe ${FILESDIR}/fakeidentd.rc fakeidentd
	insinto /etc/conf.d ; newins ${FILESDIR}/fakeidentd.confd fakeidentd
}
