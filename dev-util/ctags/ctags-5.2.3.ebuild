# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctags/ctags-5.2.3.ebuild,v 1.2 2002/05/20 05:35:55 mkennedy Exp $

S=${WORKDIR}/${P}

LICENSE="GPL-2"

DESCRIPTION="Ctags generates an index (or tag) file of C language objects found in C source and header files that allows these items to be quickly and easily located by a text editor or other utility. Currently supports 22 programming languages."

SRC_URI="http://unc.dl.sourceforge.net/sourceforge/ctags/${P}.tar.gz"
HOMEPAGE="http://ctags.sourceforge.net"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"

SLOT=""

src_compile() {
	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-posix-regex \
		--without-readlib \
		--disable-etags \
		--host=${CHOST} ||
		die
	emake || die
}

src_install () {
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die
	# namepace collision with X/Emacs-provided /usr/bin/ctags -- we
	# rename ctags to exuberant-ctags (Mandrake does this also).
	mv ${D}/usr/bin/ctags ${D}/usr/bin/exuberant-ctags
	mv ${D}/usr/share/man/man1/ctags.1 ${D}/usr/share/man/man1/exuberant-ctags.1
}
