# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/checkpassword/checkpassword-0.90-r1.ebuild,v 1.11 2004/04/10 04:38:08 kumba Exp $

inherit eutils gcc

DESCRIPTION="A uniform password checking interface for root applications"
HOMEPAGE="http://cr.yp.to/checkpwd.html"
SRC_URI="http://cr.yp.to/checkpwd/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips ~hppa amd64 ia64"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch
	epatch ${FILESDIR}/${PV}-head-1.patch

	# the -s is from the original build
	LDFLAGS="${LDFLAGS} -s"
	use pic && CFLAGS="${CFLAGS} -fPIC"
	use static && LDFLAGS="${LDFLAGS} -static"
	echo "$(gcc-getCC) ${CFLAGS}" > conf-cc
	echo "$(gcc-getCC) ${LDFLAGS}" > conf-ld
}

src_compile() {
	make || die "Error in make"
}

src_install() {
	into /
	dobin checkpassword
	dodoc CHANGES README TODO VERSION FILES SYSDEPS TARGETS
}
