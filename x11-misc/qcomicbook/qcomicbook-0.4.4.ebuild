# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qcomicbook/qcomicbook-0.4.4.ebuild,v 1.3 2009/11/21 19:44:49 maekke Exp $

EAPI="2"
inherit eutils qt4

DESCRIPTION="A viewer for comic book archives containing jpeg/png images."
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/qt-gui
	media-libs/imlib2[X]
	x11-libs/libXmu
	|| ( app-arch/unrar app-arch/rar )
	app-arch/zip"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e 's,moc-qt4,moc,g' src/Makefile.in || die "sed failed"
}

src_configure() {
	econf --with-Qt-dir="${QTDIR}"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	doicon icons/${PN}.png
	make_desktop_entry ${PN} "QComicBook" \
		${PN}.png "Graphics;Viewer;Amusement;Qt"
}
