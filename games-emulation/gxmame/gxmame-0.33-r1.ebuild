# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gxmame/gxmame-0.33-r1.ebuild,v 1.3 2004/02/10 13:25:09 mr_bones_ Exp $

inherit eutils

DESCRIPTION="frontend for XMame using the GTK library"
HOMEPAGE="http://gxmame.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	media-libs/gdk-pixbuf"
RDEPEND="nls? ( sys-devel/gettext )
	games-emulation/xmame"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-newxmame.patch
}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
