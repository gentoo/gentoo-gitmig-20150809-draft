# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mrproject/mrproject-0.7.ebuild,v 1.4 2003/09/06 22:21:01 msterret Exp $

DESCRIPTION="Project manager for Gnome2"
SRC_URI="ftp://ftp.codefactory.se/pub/software/mrproject/source/${P}.tar.gz"
HOMEPAGE="http://mrproject.codefactory.se/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="doc nls"

RDEPEND=">=x11-libs/gtk+-2.0.5
	>=x11-libs/pango-1.0.3
	>=dev-libs/glib-2.0.3
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnomeui-2.0.1
	>=dev-libs/libmrproject-${PV}
	app-text/scrollkeeper
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

src_compile() {
	local myconf
	use doc && myconf="--enable-gtk-doc" || myconf="--disable-gtk-doc"
	use nls && myconf="${myconf} --enable-nls" || myconf="${myconf} --disable-nls"

	econf ${myconf} --disable-maintainer-mode
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeL* INSTALL NEWS  README*
}
