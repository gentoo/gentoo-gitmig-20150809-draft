# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2-r3.ebuild,v 1.26 2004/04/28 22:40:48 vapier Exp $

inherit eutils

DESCRIPTION="Your basic line editor"
HOMEPAGE="http://www.gnu.org/software/ed/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/ed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE=""

DEPEND="virtual/glibc
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-gentoo.diff
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
	dodoc ChangeLog NEWS POSIX README THANKS TODO
}
