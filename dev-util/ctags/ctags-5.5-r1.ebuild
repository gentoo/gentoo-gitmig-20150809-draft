# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctags/ctags-5.5-r1.ebuild,v 1.16 2005/02/03 23:04:34 ciaranm Exp $

DESCRIPTION="Exuberant Ctags generates an index (or tag) file of objects found in source and header files that allows these items to be quickly and easily located by a text editor or other utility. Currently supports 22 programming languages."
HOMEPAGE="http://ctags.sourceforge.net"
SRC_URI="mirror://sourceforge/ctags/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 alpha x86 ~ppc sparc mips hppa ia64 ppc64 s390"
IUSE=""

DEPEND="virtual/libc"

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

	dodoc FAQ NEWS README
	dohtml EXTENDING.html ctags.html
}
