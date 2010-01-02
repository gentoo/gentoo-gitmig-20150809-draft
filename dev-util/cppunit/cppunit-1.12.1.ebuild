# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppunit/cppunit-1.12.1.ebuild,v 1.3 2010/01/02 21:58:49 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="C++ port of the famous JUnit framework for unit testing"
HOMEPAGE="http://cppunit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc examples"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen
	media-gfx/graphviz )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.10.2-asneeded.patch" \
		"${FILESDIR}/${P}-add_missing_include.patch"


	sed -i \
		-e 's|-L\($${CPPUNIT_LIB_DIR}\)|\1|' \
		-e 's|\(../../lib\)|-L\1 -L../../src/cppunit/.libs|' \
		examples/qt/qt_example.pro || die

	AT_M4DIR="${S}/config"
	eautomake
	elibtoolize
}

src_configure() {
	# Anything else than -O0 breaks on alpha
	use alpha && replace-flags "-O?" -O0

	econf \
		$(use_enable doc doxygen) \
		$(use_enable doc dot) \
		--htmldir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog BUGS NEWS README THANKS TODO doc/FAQ

	if use examples ; then
		find examples -iname "*.o" -delete
		insinto /usr/share/${PN}
		doins -r examples
	fi
}
