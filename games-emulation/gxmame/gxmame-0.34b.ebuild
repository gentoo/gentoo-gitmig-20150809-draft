# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gxmame/gxmame-0.34b.ebuild,v 1.6 2004/09/12 23:35:02 mr_bones_ Exp $

DESCRIPTION="frontend for XMame using the GTK library"
HOMEPAGE="http://gxmame.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="nls joystick"

DEPEND="virtual/x11
	=x11-libs/gtk+-2*
	=dev-libs/glib-2*
	sys-libs/zlib"
RDEPEND="nls? ( sys-devel/gettext )
	games-emulation/xmame"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:-O2 -fomit-frame-pointer -ffast-math:${CFLAGS}:" \
		-e "s:-O2:${CFLAGS}:" \
		configure
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable joystick) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
