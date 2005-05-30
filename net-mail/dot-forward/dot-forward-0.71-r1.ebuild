# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dot-forward/dot-forward-0.71-r1.ebuild,v 1.13 2005/05/30 19:02:52 swegener Exp $

inherit eutils toolchain-funcs

DESCRIPTION="reads sendmail's .forward files under qmail"
HOMEPAGE="http://cr.yp.to/dot-forward.html"
SRC_URI="http://cr.yp.to/software/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64"
IUSE=""

DEPEND="virtual/libc
	sys-apps/groff"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch
	epatch ${FILESDIR}/${PV}-head-1.patch

	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC)" > conf-ld
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
	doins dot-forward || die
}
