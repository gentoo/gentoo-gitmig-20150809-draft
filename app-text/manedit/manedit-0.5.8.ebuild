# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/manedit/manedit-0.5.8.ebuild,v 1.4 2003/04/13 20:19:33 liquidx Exp $

DESCRIPTION="Man page editor using XML tags"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"
HOMEPAGE="http://wolfpack.twu.net/ManEdit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/glibc
	virtual/x11
	=x11-libs/gtk+-1*
	sys-libs/zlib
	sys-apps/bzip2"

src_compile() {
	# It autodetects x86 processors and adds the -march option itself
	# but we don't actually want that.
	env CFLAGS="${CFLAGS}" ./configure Linux \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/usr/share \
		--enable=bzip2 \
		--enable=zlib \
		--disable="arch-i486" \
		--disable="arch-i586" \
		--disable="arch-i686" \
		--disable="arch-pentiumpro" || die "Bad Configure"
	emake || die "Compile Error"
}

src_install() {
	# fix strip error (tries to strip a shell script)
	cp manedit/Makefile.install.UNIX{,.orig}
	sed -e '/INST.*FLAGS.*-s$/s:-s::' \
		manedit/Makefile.install.UNIX.orig > manedit/Makefile.install.UNIX

	# set man dir too or FHS is violated (/usr/man)
	make \
		PREFIX=${D}/usr \
		MAN_DIR=${D}/usr/share/man/man1 \
		ICONS_DIR=${D}/usr/share/pixmaps \
		install || die "make install failed."
	
	dodoc AUTHORS LICENSE README
}
