# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-4.2.0.ebuild,v 1.6 2010/11/12 09:49:36 ssuominen Exp $

EAPI=2
inherit multilib

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www2.aquamaniac.de/sites/download/download.php?package=03&release=46&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE="chipcard debug ofx qt4"

RDEPEND=">=sys-libs/gwenhywfar-3.10.0.0
	<sys-libs/gwenhywfar-4
	>=app-misc/ktoblzcheck-1.14
	ofx? ( >=dev-libs/libofx-0.8.3 )
	chipcard? ( >=sys-libs/libchipcard-4.2.8 )
	qt4? ( x11-libs/qt-gui:4[qt3support] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"

RESTRICT="test"

src_configure() {
	local frontends="cbanking"
	use qt4 && frontends="${frontends} qbanking"

	local backends="aqhbci aqnone"
	use ofx && backends="${backends} aqofxconnect"

	local myconf qt3_libs qt3_includes
	if use qt4; then
		qt3_libs="$(pkg-config QtCore QtGui Qt3Support --libs)"
		qt3_includes="$(pkg-config QtCore QtGui Qt3Support --cflags-only-I)"
		myconf="--enable-qt3=yes"
	else
		myconf="--enable-qt3=no"
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

	use qt4 && emake qt4-port
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -rf "${D}"/usr/share/doc/${PN}
	find "${D}" -name '*.la' -delete
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
