# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rcs/rcs-5.7-r2.ebuild,v 1.14 2004/04/07 23:53:26 vapier Exp $

DESCRIPTION="Revision Control System"
HOMEPAGE="http://www.gnu.org/software/rcs/"
SRC_URI="ftp://ftp.gnu.org/gnu/rcs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ia64 amd64"

DEPEND="virtual/glibc"
RDEPEND="sys-apps/diffutils"

src_compile() {
	econf --with-diffutils || die
	cp ${FILESDIR}/conf.sh src/conf.sh
	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		man1dir=${D}/usr/share/man/man1 \
		man3dir=${D}/usr/share/man/man3 \
		man5dir=${D}/usr/share/man/man5 \
		install || die

	dodoc ChangeLog CREDITS NEWS README REFS
}
