# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/pan/pan-0.13.4.ebuild,v 1.2 2003/02/28 01:03:43 foser Exp $

IUSE="spell"

DESCRIPTION="A newsreader for the Gnome2 desktop"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/SOURCE/${P}.tar.bz2"
HOMEPAGE="http://pan.rebelbase.com"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/libxml2-2.4.22
	>=net-libs/gnet-1.1.5
	spell? ( >=app-text/gtkspell-2.0.2 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	sys-devel/gettext"

export CONFIG_PROTECT_MASK="/etc/gconf"

src_compile() {
	local myconf=""

	use spell \
		&& myconf="${myconf} --enable-gtkspell" \
		|| myconf="${myconf} --disable-gtkspell"

	econf ${myconf} || die "Configure failure"

	emake || die "Compilation failure"
}

src_install() {
	einstall || die "Installation failed"
    
	dodoc ANNOUNCE AUTHORS ChangeLog COPYING CREDITS INSTALL NEWS README TODO
}
