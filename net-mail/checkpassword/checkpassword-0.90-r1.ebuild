# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/checkpassword/checkpassword-0.90-r1.ebuild,v 1.16 2005/10/30 05:51:13 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A uniform password checking interface for root applications"
HOMEPAGE="http://cr.yp.to/checkpwd.html"
SRC_URI="http://cr.yp.to/checkpwd/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k mips ppc ~s390 ~sh sparc x86"
IUSE="pic static"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch
	epatch ${FILESDIR}/${PV}-head-1.patch

	# the -s is from the original build
	LDFLAGS="${LDFLAGS} -s"
	use pic && CFLAGS="${CFLAGS} -fPIC"
	use static && LDFLAGS="${LDFLAGS} -static"
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_compile() {
	make || die "Error in make"
}

src_install() {
	into /
	dobin checkpassword || die
	dodoc CHANGES README TODO VERSION FILES SYSDEPS TARGETS
}
