# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/maude/maude-2.1.ebuild,v 1.3 2004/07/02 04:28:16 eradicator Exp $

DESCRIPTION="Maude - A high-level specification language"
HOMEPAGE="http://maude.cs.uiuc.edu/"
SRC_URI="http://maude.cs.uiuc.edu/download/current/Maude-${PV}.tar.gz
		 http://maude.cs.uiuc.edu/download/current/full-maude.maude
		 http://maude.cs.uiuc.edu/maude2-manual/maude-manual.pdf
		 http://maude.cs.uiuc.edu/maude2-manual/maude-manual.ps
		 http://maude.cs.uiuc.edu/maude2-manual/maude-examples.tar.gz"
		# It's a bit scary, but they do in fact not
		# provide these things with version numbers
		# included!

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

RDEPEND="virtual/libc
	dev-libs/buddy
	dev-libs/libtecla
	dev-libs/gmp"

DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

S=${WORKDIR}/Maude-${PV}

src_compile() {
	# econf/emake fails with a "file not found" error.
	./configure --bindir=/usr/bin --datadir=/usr/share/${PN} || die
	make || die
}

src_install() {
	make install DESTDIR=${D}

	dodoc AUTHORS ChangeLog NEWS README
	insinto /usr/share/doc/${P}/pdf
	doins ${DISTDIR}/maude-manual.pdf
	insinto /usr/share/doc/${P}/ps
	doins ${DISTDIR}/maude-manual.ps

	insinto /usr/share/${PN}
	doins ${DISTDIR}/full-maude.maude

	insinto /usr/share/${PN}/examples
	doins ${WORKDIR}/maude-examples/*

	insinto /etc/env.d
	doins ${FILESDIR}/23maude
}
