# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-coverviewer/xmms-coverviewer-0.1.10.ebuild,v 1.2 2004/01/28 02:48:40 raker Exp $

IUSE=""

DESCRIPTION="An XMMS plugin for viewing album covers"
HOMEPAGE="http://coverviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/coverviewer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	media-sound/xmms"

src_compile() {
	local myconf="--with-gnu-ld"

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS INSTALL NEWS
}

pkg_postinst() {
	ewarn ""
	ewarn "Do not attempt to configure the plugin right away!"
	ewarn "Enable the plugin.  Sane default values will be applied."
	ewarn "After that, changing options is fine."
	ewarn "To use Internet-search, you'll need python"
	ewarn ""
}

