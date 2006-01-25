# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/cpp2latex/cpp2latex-2.3-r1.ebuild,v 1.1 2006/01/25 16:09:19 ehmsen Exp $

inherit eutils

DESCRIPTION="A program to convert C++ code to LaTeX source"
HOMEPAGE="http://roederberg.dyndns.org/~arnold/cpp2latex"
SRC_URI="http://www.arnoldarts.de/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

# although it makes sense to have tex installed, it is
# neither a compile or runtime dependency

src_unpack() {
	unpack ${A} || die
	cd ${S}/cpp2latex
	# bug 44585
	epatch ${FILESDIR}/cpp2latex-2.3.patch || die
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
}
