# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gxmame/gxmame-0.32.ebuild,v 1.1 2003/04/06 15:52:42 mholzer Exp $

IUSE="nls"

DESCRIPTION="frontend for XMame using the GTK library"
HOMEPAGE="http://gxmame.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="x11-base/xfree
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	media-libs/gdk-pixbuf"
RDEPEND="nls? ( sys-devel/gettext )
	app-emulation/xmame"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
}
