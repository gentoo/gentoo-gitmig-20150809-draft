# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fastforward/fastforward-0.51-r1.ebuild,v 1.5 2004/07/15 01:46:57 agriffis Exp $

inherit eutils fixheadtails

DESCRIPTION="handle qmail forwarding according to a cdb database"
HOMEPAGE="http://cr.yp.to/fastforward.html"
SRC_URI="http://cr.yp.to/software/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="sys-apps/groff"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch
	ht_fix_file Makefile

	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
}

src_compile() {
	emake it || die
}

src_install() {
	dodoc ALIASES BLURB CHANGES FILES INSTALL README SYSDEPS TARGETS
	dodoc THANKS TODO VERSION
	doman *.1

	insopts -o root -g qmail -m 755
	insinto /var/qmail/bin
	doins fastforward newaliases newinclude printforward printmaillist \
		setforward setmaillist
}
