# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/twittare/twittare-0.7.42.ebuild,v 1.3 2010/06/27 18:36:05 angelos Exp $

EAPI="2"

inherit qt4

DESCRIPTION="Twitter client for Linux using Qt4"
HOMEPAGE="http://www.twittare.com"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/libnotify"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-gcc-4.4-glibc-2.10.patch"
)

src_prepare() {
	# fix LDFLAGS issue
	sed -i "s/-fpic/${LDFLAGS}\ -fpic/" "${S}"/libtwnotification/makefile || die "sed failed"
	sed -i "s/-shared/${LDFLAGS}\ -shared/" "${S}"/libtwnotification/makefile || die "sed failed"
	qt4_src_prepare
}

src_configure() {
	eqmake4
}

src_compile() {
	emake -C libtwnotification || die "emake libtwnotification failed"
	emake || die "emake failed"
}

src_install() {
	dobin twittare || die "dobin failed"
	dolib.so libtwnotification/libtwnotification.so || die "dolib.so failed"
	insinto /usr/share/applications
	doins twittare.desktop || die "doins twittare.desktop failed"
	insinto /usr/share/pixmaps
	doins pixmaps/twittare-blue.png pixmaps/twittare-pink.png || die "doins pixmaps failed"
	insinto /usr/share/${PN}
	doins -r lang/ || die "doins lang failed"
	if use doc; then
		dodoc NEWS README ChangeLog || die "dodoc failed"
	fi
}
