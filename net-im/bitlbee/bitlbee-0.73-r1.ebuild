# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/bitlbee/bitlbee-0.73-r1.ebuild,v 1.1 2003/04/20 16:34:04 weeve Exp $

inherit eutils

DESCRIPTION="Bitlbee is an irc to IM gateway that support mutliple IM protocols"
HOMEPAGE="http://www.lintux.cx/bitlbee.html"
SRC_URI="http://www.lintux.cx/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${P}.tar.gz

	# Patch the default xinetd file to add/adjust values to Gentoo defaults
	cd ${S}/doc
	epatch ${FILESDIR}/${PN}-xinetd.patch
}

src_compile() {
	econf --datadir=/usr/share/bitlbee --etcdir=/etc
	emake || die "make failed"

	# make bitlbeed forking server
	cd utils
	[ -n "${CC}" ] \
		&& ${CC} ${CFLAGS} bitlbeed.c -o bitlbeed \
		|| gcc ${CFLAGS} bitlbeed.c -o bitlbeed
												
}

src_install() {
	mkdir -p ${D}/var/lib/bitlbee
	make install DESTDIR=${D} || die "install failed"

	dodoc COPYING
	dodoc doc/{AUTHORS,CHANGES,CREDITS,Installation.sgml,README,Support.sgml,TODO,Usage.sgml,user-guide.sgml}
	doman doc/bitlbee.8
	
	dobin utils/bitlbeed
	
	insinto /etc/xinetd.d
	newins doc/bitlbee.xinetd bitlbee
}

pkg_postinst() {
	chown nobody:nobody /var/lib/bitlbee
	chmod 700 /var/lib/bitlbee
}
