# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/hexter/hexter-0.6.2.ebuild,v 1.4 2009/12/22 10:08:11 maekke Exp $

DESCRIPTION="Yamaha DX7 modeling DSSI plugin"
HOMEPAGE="http://dssi.sourceforge.net/hexter.html"
SRC_URI="mirror://sourceforge/dssi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtk"

RDEPEND="gtk? ( =x11-libs/gtk+-2* sys-libs/readline sys-libs/ncurses )
	media-libs/alsa-lib
	>=media-libs/dssi-0.4
	>=media-libs/liblo-0.12"
DEPEND="${RDEPEND}
	media-libs/ladspa-sdk
	dev-util/pkgconfig"

src_compile() {
	econf $(use gtk || echo "--with-textui")
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
}
