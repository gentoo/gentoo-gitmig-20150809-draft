# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/sinek/sinek-0.7.ebuild,v 1.10 2004/07/14 22:10:52 agriffis Exp $

IUSE="nls guile gnome"

DESCRIPTION="GTK interface for xine"
HOMEPAGE="http://sinek.sourceforge.net"
SRC_URI="mirror://sourceforge/sinek/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/xine-lib-0.9.12
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	guile? ( dev-util/guile )"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile(){
	local myconf

	use nls || myconf="${myconf} --disable-nls"
	use guile || myconf="${myconf} --disable-guile"

	econf ${myconf} || die
	emake || die
}

src_install(){
	einstall || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README

	use gnome && ( \
		insinto /usr/share/pixmaps
		doins pixmaps/${PN}.xpm
		insinto /usr/share/gnome/apps/Multimedia
		doins ${PN}.desktop
	)
}
