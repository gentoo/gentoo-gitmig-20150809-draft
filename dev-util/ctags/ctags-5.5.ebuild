# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctags/ctags-5.5.ebuild,v 1.13 2005/02/03 23:04:34 ciaranm Exp $

DESCRIPTION="Exuberant Ctags generates an index (or tag) file of objects found in source and header files that allows these items to be quickly and easily located by a text editor or other utility. Currently supports 22 programming languages."
HOMEPAGE="http://ctags.sourceforge.net"
SRC_URI="mirror://sourceforge/ctags/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ppc-macos"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf --with-posix-regex --without-readlib --disable-etags || die
	emake || die "emake failed"
}

src_install () {
	make prefix=${D}/usr mandir=${D}/usr/share/man install \
		|| die "make install failed"
	# namepace collision with X/Emacs-provided /usr/bin/ctags -- we
	# rename ctags to exuberant-ctags (Mandrake does this also).
	mv ${D}/usr/bin/ctags ${D}/usr/bin/exuberant-ctags
	mv ${D}/usr/share/man/man1/ctags.1 ${D}/usr/share/man/man1/exuberant-ctags.1

	dodoc FAQ NEWS README
	dohtml EXTENDING.html ctags.html
}
