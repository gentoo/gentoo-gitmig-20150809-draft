# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/pan/pan-0.13.1.ebuild,v 1.1 2002/10/15 12:39:43 foser Exp $

IUSE="nls spell"

DESCRIPTION="A newsreader for the Gnome2 desktop"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/SOURCE/${P}.tar.bz2"
HOMEPAGE="http://pan.rebelbase.com"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.4
	>=dev-libs/libxml2-2.4.22
	spell? ( >=app-text/gtkspell-2.0.2 )"

RDEPEND="nls? ( sys-devel/gettext )"

export CONFIG_PROTECT_MASK="/etc/gconf"

src_compile() {
	local myconf=""

	use nls   || myconf="--disable-nls"
	use spell || myconf="$myconf --disable-gtkspell"

	econf $myconf || die "Configure failure"

	emake || die "Compilation failure"
}

src_install() {
	einstall || die "Installation failed"
    
	dodoc ANNOUNCE AUTHORS ChangeLog COPYING CREDITS INSTALL NEWS README TODO
}
