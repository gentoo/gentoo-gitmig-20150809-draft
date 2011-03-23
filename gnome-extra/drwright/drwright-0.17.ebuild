# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/drwright/drwright-0.17.ebuild,v 1.15 2011/03/23 07:59:18 nirbheek Exp $

EAPI="1"

inherit gnome2 flag-o-matic toolchain-funcs eutils

DESCRIPTION="A GNOME2 Applet that forces you to take regular breaks to prevent RSI."
HOMEPAGE="http://www.imendio.com/projects/drwright/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 sparc ~ppc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.4:2
	>=x11-libs/pango-1.2
	>=dev-libs/glib-2.0.3:2
	>=gnome-base/gconf-1.2:2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2:2.0
	x11-libs/libXScrnSaver"

DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

src_unpack() {
	gnome2_src_unpack

	# get rid of strict-aliasing warnings
	sed -i -e 's/-Wall//' src/Makefile.{in,am}
	cd "${S}"
	epatch "${FILESDIR}/drwright-remowe-Werror.patch"
}
