# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.10.3.ebuild,v 1.1 2004/03/17 22:04:43 leonardop Exp $

inherit gnome2

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="x86"

IUSE="debug"

RDEPEND=">=gnome-base/libbonobo-1.107
	>=gnome-base/ORBit2-2.3.100
	>=gnome-extra/at-spi-0.12.1
	>=dev-libs/glib-1.3.11
	>=x11-libs/gtk+-2.1.0
	dev-libs/popt"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING NEWS README"


src_compile() {
	local myconf=""

	use debug && myconf="--enable-debug=yes"

	econf $myconf || die "./configure failure"

	# emake borks the compilation process.
	make || die "compile failure"
}
