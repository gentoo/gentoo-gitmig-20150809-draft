# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qcomicbook/qcomicbook-0.4.0.ebuild,v 1.2 2008/01/09 08:33:34 nelchael Exp $

inherit autotools eutils qt4

DESCRIPTION="A viewer for comic book archives containing jpeg/png images."
HOMEPAGE="http://linux.bydg.org/~yogin"
SRC_URI="http://linux.bydg.org/~yogin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="$(qt4_min_version 4.0)
	media-libs/imlib2
	|| ( app-arch/unrar app-arch/rar )
	app-arch/zip"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}/src/"
	sed -i -e 's,moc-qt4,moc,g' Makefile.am || die "sed failed"
}

src_compile() {
	econf --with-Qt-dir="${QTDIR}" || die "econf failed"
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	doicon icons/${PN}.png
	make_desktop_entry ${PN} "QComicBook" \
		${PN}.png "Graphics;Viewer;Amusement;Qt"
}
