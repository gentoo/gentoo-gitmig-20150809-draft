# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcwipe/bcwipe-1.5_p3.ebuild,v 1.5 2006/04/19 03:55:10 weeve Exp $

inherit toolchain-funcs

DESCRIPTION="BCWipe secure file removal utility"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BCWipe-${PV/_p/-}.tar.gz
	http://www.jetico.com/linux/BCWipe.doc.tgz"

LICENSE="bestcrypt"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ppc sparc x86"

DEPEND="virtual/libc"
RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	emake CC=$(tc-getCC) DEFS="${CFLAGS}"|| die "Make failed"
}

src_test() {
	echo "abc123" >> testfile
	./bcwipe -f testfile || dir "bcwipe test failed"
	[ -f testfile ] && die "test file still exists. bcwipe should of deleted it"
}


src_install() {
	dobin bcwipe || die
	doman bcwipe.1
	cd ../bcwipe-help
	dodir /usr/share/doc/${PF}
	cp -r * ${D}/usr/share/doc/${PF}
}
