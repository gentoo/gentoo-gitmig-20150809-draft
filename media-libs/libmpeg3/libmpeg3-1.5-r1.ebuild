# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.5-r1.ebuild,v 1.20 2003/09/06 23:59:48 msterret Exp $

inherit flag-o-matic

DESCRIPTION="An mpeg library for linux"
HOMEPAGE="http://heroinewarrior.com/libmpeg3.php3"
SRC_URI="http://heroinewarrior.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"

RDEPEND="sys-libs/zlib
	media-libs/jpeg"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/${PN}

filter-flags -fPIC
filter-flags -fno-common
[ $ARCH = alpha ] && append-flags -fPIC
[ $ARCH = hppa ] && append-flags -fPIC
[ $ARCH = amd64 ] && append-flags -fPIC
# http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml
has_version 'sys-devel/hardened-gcc' && append-flags '-yet_exec'

src_unpack() {
	unpack ${A}
	cd ${S}

	# The Makefile is patched to install the header files as well.
	# This patch was generated using the info in the src.rpm that
	# SourceForge provides for this package.
	patch -p1 < ${FILESDIR}/libmpeg3-gentoo-patch-part1
}

src_compile() {
	make || die
}

src_install() {
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
