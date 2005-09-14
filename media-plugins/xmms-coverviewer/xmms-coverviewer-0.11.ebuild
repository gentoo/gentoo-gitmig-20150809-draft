# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-coverviewer/xmms-coverviewer-0.11.ebuild,v 1.8 2005/09/14 05:47:36 agriffis Exp $

IUSE=""

DESCRIPTION="An XMMS plugin for viewing album covers"
HOMEPAGE="http://coverviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/coverviewer/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ~ppc sparc x86"

DEPEND="media-libs/gdk-pixbuf
	media-sound/xmms
	media-libs/id3lib"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS NEWS
}

pkg_postinst() {
	ewarn
	ewarn "To use Internet-search, you'll need python"
	ewarn
}
