# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qcomicbook/qcomicbook-0.2.3.ebuild,v 1.2 2005/07/11 23:19:07 smithj Exp $

inherit eutils

DESCRIPTION="QComicBook is a viewer for comic book archives containing jpeg/png images."
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/x11
	>=x11-libs/qt-3.3.3"

RDEPEND="${DEPEND}
	app-arch/unrar
	app-arch/rar
	app-arch/zip"

src_compile() {
	econf --with-Qt-dir=${QTDIR} || die "Configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README TODO ChangeLog AUTHORS
}
