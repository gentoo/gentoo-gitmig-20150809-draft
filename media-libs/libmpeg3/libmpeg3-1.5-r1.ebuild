# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.5-r1.ebuild,v 1.16 2003/07/18 05:12:07 gmsoft Exp $

inherit flag-o-matic

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="An mpeg library for linux"
SRC_URI="http://heroinewarrior.com/${P}.tar.gz"
HOMEPAGE="http://heroinewarrior.com/libmpeg3.php3"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc ~alpha hppa"

RDEPEND="sys-libs/zlib 
	media-libs/jpeg"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

filter-flags -fPIC
filter-flags -fno-common
[ $ARCH = alpha ] && append-flags -fPIC
[ $ARCH = hppa ] && append-flags -fPIC

src_unpack() {

	unpack ${A}
	cd ${S}

	# The Makefile is patched to install the header files as well.
	# This patch was generated using the info in the src.rpm that
	# SourceForge provides for this package.
	patch -p1 < ${FILESDIR}/libmpeg3-gentoo-patch-part1
}

src_compile() {
	
	export CFLAGS=${CFLAGS}
	make ${myconf} || die
}

src_install () {

	# This patch patches the .h files that get installed into /usr/include
	# to show the correct include syntax '<>' instead of '""'  This patch
	# was also generated using info from SF's src.rpm

	patch -p1 < ${FILESDIR}/libmpeg3-gentoo-patch-part2
	
	dodir /usr/bin
	
	make \
		DESTDIR=${D}/usr \
		install || die
	
	dolib.a ${CHOST%%-*}/libmpeg3.a
	
	dohtml -r docs

}
