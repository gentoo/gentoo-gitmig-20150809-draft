# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/manedit/manedit-0.5.6.ebuild,v 1.4 2002/08/16 02:42:01 murphy Exp $

DESCRIPTION="Man page editor using XML tags"
HOMEPAGE="http://wolfpack.twu.net/ManEdit"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"
S=${WORKDIR}/${P}


DEPEND="virtual/glibc
	virtual/x11
	x11-libs/gtk+
	sys-libs/zlib
	sys-apps/bzip2"


src_compile() {

	# It autodetects x86 processors and adds the -march option itself
	# but we don't actually want that.
        env CFLAGS="${CFLAGS}" ./configure Linux \
	        --prefix=/usr \
	        --enable=bzip2 \
	        --enable=zlib \
	        --disable="arch-i486" \
	        --disable="arch-i586" \
	        --disable="arch-i686" \
	        --disable="arch-pentiumpro" || die "Bad Configure"
	
	emake || die "Compile Error"
}

src_install() {
	make PREFIX=${D} install || die "make install failed."
	dodoc AUTHORS LICENSE README
}
