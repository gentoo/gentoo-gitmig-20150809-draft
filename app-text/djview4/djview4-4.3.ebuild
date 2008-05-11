# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/djview4/djview4-4.3.ebuild,v 1.2 2008/05/11 21:39:34 aballier Exp $

EAPI=1

inherit eutils versionator qt4 toolchain-funcs

MY_P=${PN}-$(replace_version_separator 2 '-')

DESCRIPTION="Portable DjVu viewer using Qt4"
HOMEPAGE="http://djvu.sourceforge.net/djview4.html"
SRC_URI="mirror://sourceforge/djvu/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
RDEPEND=">=app-text/djvu-3.5.19
	|| ( ( x11-libs/qt-gui x11-libs/qt-core ) >=x11-libs/qt-4.1.1:4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-2)"

src_compile() {
	QTDIR=/usr econf $(use_enable debug) \
		--disable-nsdejavu \
		--disable-desktopfiles || die "econf failed"

	emake CC=$(tc-getCC) CXX=$(tc-getCXX) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	#remove conflicting symlinks
	rm -f "${D}/usr/bin/djview" "${D}/usr/share/man/man1/djview.1"

	dodoc README TODO NEWS

	cd desktopfiles
	insinto /usr/share/icons/hicolor/32x32/apps
	newins hi32-djview4.png djvulibre-djview4.png
	domenu djvulibre-djview4.desktop
}
