# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-coverviewer/xmms-coverviewer-0.11.ebuild,v 1.1 2004/06/08 06:43:53 raker Exp $

IUSE=""

DESCRIPTION="An XMMS plugin for viewing album covers"
HOMEPAGE="http://coverviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/coverviewer/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	media-sound/xmms
	media-libs/id3lib"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS INSTALL NEWS
}

pkg_postinst() {
	ewarn ""
	ewarn "To use Internet-search, you'll need python"
	ewarn ""
}
