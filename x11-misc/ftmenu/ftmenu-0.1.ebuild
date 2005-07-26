# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ftmenu/ftmenu-0.1.ebuild,v 1.2 2005/07/26 14:14:59 dholm Exp $

DESCRIPTION="A tray menu for the Fluxbox toolbar"
HOMEPAGE="http://ftmenu.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="dev-util/pkgconfig"
RDEPEND="x11-wm/fluxbox
	>=x11-libs/gtk+-2.6"


src_compile() {
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto /usr/share/${PN} ; doins img/fb.xpm
	dodoc AUTHORS README ChangeLog
}

pkg_postinst() {
	echo
	einfo "To use ftmenu, edit your ~/.fluxbox/menu file and modify the [begin]"
	einfo "line to contain the path to an icon of your choice."
	einfo
	einfo "For example, to use the default ftmenu xpm icon:"
	einfo "   [begin] (Fluxbox-0.9.12) </usr/share/ftmenu/fb.xpm>"
	einfo
	einfo "Next, add 'ftmenu &' to your X startup file (~/.xinitrc or ~/.xsession)."
	echo
}
