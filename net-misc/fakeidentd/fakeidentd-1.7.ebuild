# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/fakeidentd/fakeidentd-1.7.ebuild,v 1.4 2003/02/13 14:49:51 vapier Exp $

# This identd is nearly perfect for a NAT box. It runs in one
# process (doesn't fork()) and isnt very susceptible to DOS attack.

DESCRIPTION="A static, secure identd. One source file only!"
HOMEPAGE="http://www.guru-group.fi/~too/sw/"
S="${WORKDIR}"
SRC_URI="http://www.guru-group.fi/~too/sw/releases/identd.c
	http://www.guru-group.fi/~too/sw/identd.readme"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	cp ${DISTDIR}/identd.c ${DISTDIR}/identd.readme ${WORKDIR}
}

src_compile() {
	gcc identd.c -o ${PN} ${CFLAGS} || die
}

src_install() {
	dosbin ${PN}
	# Changelog in source is more current. Its only ~13kB anyway.
	dodoc identd.readme identd.c
	
	exeinto /etc/init.d
	newexe ${FILESDIR}/fakeidentd.rc fakeidentd
	insinto /etc/conf.d
	newins ${FILESDIR}/fakeidentd.confd fakeidentd
}
