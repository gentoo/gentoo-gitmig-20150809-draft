# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-news/pan/pan-0.12.93.ebuild,v 1.1 2002/08/07 18:31:25 stroke Exp $

inherit debug

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

	# gtkspell breaks things now.
	myconf="${myconf} --disable-gtkspell"	
	econf --enable-debug=yes $myconf || die "Configure failure"

	emake || die "Compilation failure"
}

src_install() {
	einstall || die "Installation failed"
    
	dodoc ANNOUNCE AUTHORS ChangeLog COPYING CREDITS INSTALL NEWS README TODO
}
