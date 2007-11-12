# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/djview4/djview4-4.2.ebuild,v 1.2 2007/11/12 00:23:44 mr_bones_ Exp $

inherit eutils versionator qt4 toolchain-funcs autotools

DESCRIPTION="Portable DjVu viewer using Qt4"
HOMEPAGE="http://djvu.sourceforge.net/djview4.html"
SRC_URI="mirror://sourceforge/djvu/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
DEPEND=">=app-text/djvu-3.5.19
	$(qt4_min_version 4.1)"
RDEPEND="${DEPEND}"

src_unpack(){
	unpack ${A}
	cd "${S}"
	# Needed, their configure seems poorly generated...
	eautoreconf
}

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
