# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/lzo/lzo-1.08-r1.ebuild,v 1.21 2006/04/23 13:32:39 flameeyes Exp $

inherit eutils gnuconfig libtool

DESCRIPTION="An extremely fast compression and decompression library"
HOMEPAGE="http://www.oberhumer.com/opensource/lzo/"
SRC_URI="http://www.oberhumer.com/opensource/lzo/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="x86? ( dev-lang/nasm )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-exec-stack.patch
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
	sed -i -e s,-O2,,g ${S}/aclocal.m4
	autoconf

	elibtoolize
}

src_compile() {
	#Needed on mips and probablly others
	gnuconfig_update

	econf --enable-shared || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README THANKS doc/LZO*
	docinto examples
	dodoc examples/*.c examples/Makefile
}
