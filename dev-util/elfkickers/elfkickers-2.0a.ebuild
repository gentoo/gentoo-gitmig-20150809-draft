# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/elfkickers/elfkickers-2.0a.ebuild,v 1.3 2003/09/06 08:39:20 msterret Exp $

IUSE=""

MY_PN=${PN/elf/ELF}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="ELFkickers is a collection of programs to manipulate ELF files: sstrip, rebind, elfls, elftoc, ebfc"
HOMEPAGE="http://www.muppetlabs.com/~breadbox/software/elfkickers.html"
SRC_URI="http://www.muppetlabs.com/~breadbox/pub/software/${MY_PN}-${PV}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="virtual/glibc
	 dev-lang/nasm"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	# custom made patch to keep the compiler warnings down
	epatch ${FILESDIR}/${P}.diff
}

src_compile() {
	cd ${S}
	emake -C ebfc
	emake -C elfls
	emake -C elftoc
	emake -C rebind
	emake -C sstrip
	# emake -C tiny
}

src_install() {
	cd ${S}
	mv -f ebfc/README README.ebfc
	mv -f elfls/README README.elfls
	mv -f elftoc/README README.elftoc
	mv -f rebind/README README.rebind
	mv -f sstrip/README README.sstrip
	insinto /usr
	dobin ebfc/ebfc sstrip/sstrip elfls/elfls elftoc/elftoc rebind/rebind
	doman */*.1
	dodoc COPYING Changelog README
	dodoc README.ebfc README.elfls README.elftoc README.rebind README.sstrip ebfc/elfparts.txt
}
