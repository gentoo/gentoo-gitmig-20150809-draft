# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/elfutils/elfutils-0.76-r2.ebuild,v 1.1 2003/05/14 10:41:07 cretin Exp $

inherit eutils

IUSE=""

S="${WORKDIR}/${P}"
DESCRIPTION="Libraries and utilities to handle compiled objects.
This should be a drop in replacement for libelf."
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.redhat.com/"

LICENSE="OpenSoftware"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"

DEPEND="virtual/glibc
	>=sys-devel/gcc-3.2.1-r6
	!dev-libs/libelf"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-hidden.diff

	for x in $(find ${S}/ -name Makefile.in) ; do
		cp ${x} ${x}.orig
		sed -e 's:-Werror::g' \
		${x}.orig > ${x}
	done
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
