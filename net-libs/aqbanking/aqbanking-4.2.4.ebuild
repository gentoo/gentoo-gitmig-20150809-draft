# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-4.2.4.ebuild,v 1.3 2010/11/12 09:49:36 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www.aquamaniac.de/sites/download/download.php?package=03&release=50&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="chipcard debug ofx qt4"

RDEPEND=">=sys-libs/gwenhywfar-3.11.3
	<sys-libs/gwenhywfar-4
	>=app-misc/ktoblzcheck-1.24
	ofx? ( >=dev-libs/libofx-0.9.1 )
	chipcard? ( >=sys-libs/libchipcard-4.2.9 )
	qt4? ( x11-libs/qt-gui:4[qt3support] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# no-go
MAKEOPTS="${MAKEOPTS} -j1"
RESTRICT="test"

src_prepare() {
	sed -i \
		-e 's/$(ADD_ACLOCAL_FLAGS)//' \
		Makefile.am || die

	epatch "${FILESDIR}"/${P}-gcc_detection.patch
	eautoreconf
}

src_configure() {
	local frontends=""
	use qt4 && frontends="${frontends} qbanking q4banking"

	local backends="aqhbci aqnone"
	use ofx && backends="${backends} aqofxconnect"

	local myconf qt3_libs qt3_includes
	if use qt4; then
		qt3_libs="$(pkg-config QtCore QtGui Qt3Support --libs)"
		qt3_includes="$(pkg-config QtCore QtGui Qt3Support --cflags-only-I)"
		myconf="--enable-qt3=yes --enable-qt4=yes --with-qt4-moc=/usr/bin/moc --with-qt4-uic=/usr/bin/uic"
	else
		myconf="--enable-qt3=no --enable-qt4=no"
	fi

	econf \
		QTDIR="/usr/$(get_libdir)/qt4" \
		QT3TO4="/usr/bin/qt3to4" \
		qt3_libs="${qt3_libs}" \
		qt3_includes="${qt3_includes}" \
		--disable-dependency-tracking \
		$(use_enable debug) \
		--with-frontends="${frontends}" \
		--with-backends="${backends}" \
		--with-docpath=/usr/share/doc/${PF}/apidoc \
		${myconf}
}

src_compile() {
	if use qt4; then
		emake qt4-port || die
	fi

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -rf "${D}"/usr/share/doc/${PN}
	find "${D}" -name '*.la' -delete
	dodoc AUTHORS ChangeLog NEWS README TODO
}
