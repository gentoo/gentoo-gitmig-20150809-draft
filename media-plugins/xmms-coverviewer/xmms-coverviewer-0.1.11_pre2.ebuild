# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-coverviewer/xmms-coverviewer-0.1.11_pre2.ebuild,v 1.3 2004/06/24 23:37:56 agriffis Exp $

IUSE=""

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An XMMS plugin for viewing album covers"
HOMEPAGE="http://coverviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/coverviewer/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa"

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
