# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hashit/hashit-0.9.3.ebuild,v 1.4 2004/11/07 10:32:13 pyrania Exp $

DESCRIPTION="Hashit is a library of generic hash tables that supports different collision handling methods with one common interface. Both data and keys can be of any type. It is small and easy to use."
HOMEPAGE="http://www.pleyades.net/david/projects/"
SRC_URI="http://www.pleyades.net/david/projects/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	./0 --prefix=${D}/usr --infodir=${D}/usr/share/info:${D}/usr/X11R6/info --enable-REENTRANT
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dosym libhashit.so /usr/lib/libhashit.so.0
}
