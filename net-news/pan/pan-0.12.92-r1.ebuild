# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-news/pan/pan-0.12.92-r1.ebuild,v 1.1 2002/08/04 09:15:47 leonardop Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

DESCRIPTION="A newsreader for the Gnome2 desktop"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/SOURCE/${P}.tar.bz2"
HOMEPAGE="http://pan.rebelbase.com"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/libxml2-2.4.22
	dev-libs/libunicode
	spell? ( >=app-text/gtkspell-2.0.0 )"

RDEPEND="nls? ( sys-devel/gettext )"

export CONFIG_PROTECT_MASK="/etc/gconf"

src_compile() {
	local myconf=""

	use nls   || myconf="--disable-nls"
	use spell || myconf="$myconf --disable-gtkspell"
	
	econf --enable-debug=yes $myconf || die "Configure failure"

	emake || die "Compilation failure"
}

src_install() {
	einstall || die "Installation failed"
    
	dodoc ANNOUNCE AUTHORS ChangeLog COPYING CREDITS INSTALL NEWS README TODO
}
