# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppunit/cppunit-1.10.2.ebuild,v 1.10 2005/09/24 02:52:12 vapier Exp $

inherit eutils

DESCRIPTION="C++ port of the famous JUnit framework for unit testing"
HOMEPAGE="http://cppunit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc"
RESTRICT="test"

DEPEND="doc? ( app-doc/doxygen )
	media-gfx/graphviz"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
}

src_compile() {
	econf $(use_enable doc doxygen) || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS NEWS README THANKS TODO
	# the package automatically puts its docs into /usr/share/cppunit
	# move them to the standard location and clean up
	mv ${D}/usr/share/cppunit/html ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/share/cppunit
}
