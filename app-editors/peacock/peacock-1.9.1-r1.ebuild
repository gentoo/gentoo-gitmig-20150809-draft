# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/peacock/peacock-1.9.1-r1.ebuild,v 1.1 2007/08/17 04:13:14 leonardop Exp $

inherit fdo-mime

DESCRIPTION="A simple GTK HTML editor"
SRC_URI="mirror://sourceforge/peacock/${P}.tar.gz"
HOMEPAGE="http://peacock.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
SLOT="0"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.2
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/libglade-2.0.1
	>=x11-libs/gtksourceview-0.5
	=gnome-extra/gtkhtml-3.0*"

RDEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"


src_install() {
	make "DESTDIR=${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO

	# menu item
	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
