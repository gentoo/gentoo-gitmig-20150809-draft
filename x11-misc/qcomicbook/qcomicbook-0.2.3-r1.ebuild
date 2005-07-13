# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qcomicbook/qcomicbook-0.2.3-r1.ebuild,v 1.1 2005/07/13 15:15:15 smithj Exp $

inherit eutils

DESCRIPTION="QComicBook is a viewer for comic book archives containing jpeg/png images."
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE=""

DEPEND="virtual/x11
	>=x11-libs/qt-3.3.3"

RDEPEND="${DEPEND}
	app-arch/unrar
	!ppc? ( app-arch/rar )
	app-arch/zip"

src_compile() {
	econf --with-Qt-dir=${QTDIR} || die "Configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	# makes a pretty desktop icon and such
	dodir /usr/share/pixmaps
	cp icons/${PN}.png ${D}/usr/share/pixmaps
	make_desktop_entry qcomicbook
	epause
	epause
	epause

	dodoc README TODO ChangeLog AUTHORS
}
