# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/ncompress/ncompress-4.2.4.1.ebuild,v 1.3 2006/09/29 13:41:13 ranger Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Another uncompressor for compatibility"
HOMEPAGE="http://ncompress.sourceforge.net/"
SRC_URI="mirror://sourceforge/ncompress/${P}.tar.gz
	http://ftp.debian.org/debian/pool/main/n/ncompress/ncompress_4.2.4-15.diff.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}"/ncompress_4.2.4-15.diff.gz
}

src_compile() {
	sed \
		-e "s:options= :options= ${CFLAGS} -DNOFUNCDEF :" \
		-e "s:CC=cc:CC=$(tc-getCC):" \
		Makefile.def > Makefile
	make || die
}

src_install() {
	dobin compress || die
	dosym compress /usr/bin/uncompress
	doman compress.1
	dodoc Acknowleds Changes LZW.INFO README
}
