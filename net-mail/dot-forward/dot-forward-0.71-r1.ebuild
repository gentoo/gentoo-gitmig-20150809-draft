# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dot-forward/dot-forward-0.71-r1.ebuild,v 1.2 2003/03/16 23:13:16 wwoods Exp $

inherit eutils

DESCRIPTION="reads sendmail's .forward files under qmail"
HOMEPAGE="http://cr.yp.to/dot-forward.html"
SRC_URI="http://cr.yp.to/software/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc
	sys-apps/groff"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch

	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
}

src_compile() {
	emake it || die
}

src_install() {				 
	dodoc BLURB CHANGES FILES INSTALL README SYSDEPS TARGETS THANKS
	dodoc TODO VERSION
	doman *.1
 
	insopts -o root -g qmail -m 755
	insinto /var/qmail/bin
	doins dot-forward
}
