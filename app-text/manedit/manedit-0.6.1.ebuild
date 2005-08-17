# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/manedit/manedit-0.6.1.ebuild,v 1.2 2005/08/17 17:46:15 fuzzyray Exp $

DESCRIPTION="Man page editor using XML tags"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"
HOMEPAGE="http://wolfpack.twu.net/ManEdit/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc x86"
IUSE=""

DEPEND="virtual/libc
	virtual/x11
	=x11-libs/gtk+-1*
	sys-libs/zlib
	app-arch/bzip2"

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
