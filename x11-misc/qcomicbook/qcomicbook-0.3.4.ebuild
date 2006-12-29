# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qcomicbook/qcomicbook-0.3.4.ebuild,v 1.1 2006/12/29 22:47:11 troll Exp $

inherit eutils qt3

DESCRIPTION="A viewer for comic book archives containing jpeg/png images."
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)
	media-libs/imlib2"
RDEPEND="${DEPEND}
	|| ( app-arch/unrar app-arch/rar )
	app-arch/zip"

src_compile() {
	econf --with-Qt-dir="${QTDIR}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# makes a pretty desktop icon and such
	dodir /usr/share/pixmaps
	cp icons/${PN}.png "${D}/usr/share/pixmaps"
	make_desktop_entry qcomicbook

	dodoc README TODO ChangeLog AUTHORS
}
