# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/checkpassword/checkpassword-0.90-r1.ebuild,v 1.13 2004/06/24 23:19:58 agriffis Exp $

inherit eutils gcc

DESCRIPTION="A uniform password checking interface for root applications"
HOMEPAGE="http://cr.yp.to/checkpwd.html"
SRC_URI="http://cr.yp.to/checkpwd/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64"
IUSE=""

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
	dobin checkpassword || die
	dodoc CHANGES README TODO VERSION FILES SYSDEPS TARGETS
}
