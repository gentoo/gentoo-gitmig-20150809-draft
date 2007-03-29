# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppunit/cppunit-1.11.6.ebuild,v 1.6 2007/03/29 14:23:47 gustavoz Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit eutils autotools

DESCRIPTION="C++ port of the famous JUnit framework for unit testing"
HOMEPAGE="http://cppunit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="doc"
RESTRICT="test"

DEPEND="doc? ( app-doc/doxygen
	media-gfx/graphviz )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.10.2-asneeded.patch"
	AT_M4DIR="${S}/config" eautomake

	elibtoolize
}

src_compile() {
	econf \
		$(use_enable doc doxygen) \
		$(use_enable doc dot) \
		|| die "configure failed"
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
