# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctags/ctags-5.5-r1.ebuild,v 1.1 2003/05/26 16:27:45 agriffis Exp $

DESCRIPTION="Ctags generates an index (or tag) file of C language objects found in C source and header files that allows these items to be quickly and easily located by a text editor or other utility. Currently supports 22 programming languages."
SRC_URI="mirror://sourceforge/ctags/${P}.tar.gz"
HOMEPAGE="http://ctags.sourceforge.net"

DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha x86 ~ppc ~sparc"
IUSE=""

src_compile() {
	econf \
		--with-posix-regex \
		--without-readlib \
		--disable-etags \
		--enable-tmpdir=/tmp || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall || die "einstall failed"

	# namepace collision with X/Emacs-provided /usr/bin/ctags -- we
	# rename ctags to exuberant-ctags (Mandrake does this also).
	mv ${D}/usr/bin/{ctags,exuberant-ctags}
	mv ${D}/usr/share/man/man1/{ctags,exuberant-ctags}.1

	dodoc COPYING FAQ NEWS README 
	dohtml EXTENDING.html ctags.html
}
