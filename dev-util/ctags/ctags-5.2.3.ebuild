# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctags/ctags-5.2.3.ebuild,v 1.3 2002/07/23 10:38:07 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Ctags generates an index (or tag) file of C language objects found in C source and header files that allows these items to be quickly and easily located by a text editor or other utility. Currently supports 22 programming languages."
SRC_URI="mirror://sourceforge/ctags/${P}.tar.gz"
HOMEPAGE="http://ctags.sourceforge.net"

DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	econf \
		--with-posix-regex \
		--without-readlib \
		--disable-etags || die

	emake || die
}

src_install () {
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die
	# namepace collision with X/Emacs-provided /usr/bin/ctags -- we
	# rename ctags to exuberant-ctags (Mandrake does this also).
	mv ${D}/usr/bin/ctags ${D}/usr/bin/exuberant-ctags
	mv ${D}/usr/share/man/man1/ctags.1 ${D}/usr/share/man/man1/exuberant-ctags.1
}
