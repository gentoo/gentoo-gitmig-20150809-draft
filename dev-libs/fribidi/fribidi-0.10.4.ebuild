# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fribidi/fribidi-0.10.4.ebuild,v 1.12 2004/06/24 23:10:22 agriffis Exp $

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="http://fribidi.sourceforge.net/"
SRC_URI="mirror://sourceforge/fribidi/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die "emake failed"
	make test || die "make test failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README ChangeLog THANKS TODO ANNOUNCE
}
