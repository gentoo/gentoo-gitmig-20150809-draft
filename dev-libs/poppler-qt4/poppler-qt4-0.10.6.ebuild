# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/poppler-qt4/poppler-qt4-0.10.6.ebuild,v 1.1 2009/04/16 23:25:12 loki_val Exp $

EAPI=2

POPPLER_MODULE=qt4/src
POPPLER_PKGCONFIG=poppler-qt4.pc

inherit poppler

DESCRIPTION="Qt4 bindings for poppler"
SRC_URI="${SRC_URI}
	test? ( mirror://gentoo/poppler-test-0.9.2.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND="
	~dev-libs/poppler-${PV}
	>=x11-libs/qt-core-4.4.2:4
	>=x11-libs/qt-gui-4.4.2:4
	>=x11-libs/qt-test-4.4.2:4
	"
DEPEND="
	${RDEPEND}
	"

src_compile() {
	POPPLER_MODULE_S="${S}/poppler" poppler_src_compile libpoppler-arthur.la
	poppler_src_compile
	use test && POPPLER_MODULE_S="${S}/qt4/tests" poppler_src_compile
}

src_test() {
	cd "${S}/qt4/tests"
	emake check
}
