# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2-r3.ebuild,v 1.23 2003/12/17 03:51:34 brad_mssw Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Your basic line editor"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/ed/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/ed/"
KEYWORDS="x86 amd64 ppc sparc alpha hppa mips arm ia64 ppc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	./configure --prefix=/ --host=${CHOST} || die
	emake || die
}

src_install() {
	chmod 0644 ${S}/ed.info
	make prefix=${D}/ \
		mandir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		install || die

	dodoc COPYING ChangeLog NEWS POSIX README THANKS TODO
}
