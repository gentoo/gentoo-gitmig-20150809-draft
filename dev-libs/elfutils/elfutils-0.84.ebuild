# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/elfutils/elfutils-0.84.ebuild,v 1.10 2004/03/23 03:50:58 weeve Exp $

inherit eutils

IUSE=""

S="${WORKDIR}/${P}"
DESCRIPTION="Libraries and utilities to handle compiled objects.
This should be a drop in replacement for libelf."
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.redhat.com/"

LICENSE="OpenSoftware"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~alpha hppa ~mips"

DEPEND=">=sys-libs/glibc-2.3.2
	>=sys-devel/binutils-2.14.90.0.6
	>=sys-devel/gcc-3.2.1-r6
	!dev-libs/libelf"

src_unpack() {
	unpack ${A}

	for x in $(find ${S}/ -name Makefile.in) ; do
		cp ${x} ${x}.orig
		sed -e 's:-Werror::g' \
		${x}.orig > ${x}
	done

	use alpha && epatch ${FILESDIR}/${P}-atime.diff
	use mips && epatch ${FILESDIR}/${P}-atime.diff
}

src_compile() {
	econf --program-prefix="eu-" \
		--enable-shared || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# Remove stuff we do not use ...
	rm -f ${D}/usr/bin/eu-ld
	rm -f ${D}/usr/include/elfutils/lib{asm,dw,dwarf}.h
	rm -f ${D}/usr/lib/lib{asm,dw}-${PV}.so
	rm -f ${D}/usr/lib/lib{asm,dw}.so*
	rm -f ${D}/usr/lib/lib{asm,dw,dwarf}.a
	rm -rf ${D}/usr/usr

	dodoc AUTHORS COPYING ChangeLog NEWS NOTES README THANKS TODO
}
