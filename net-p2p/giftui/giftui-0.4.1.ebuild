# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/giftui/giftui-0.4.1.ebuild,v 1.5 2004/07/09 01:35:30 squinky86 Exp $

inherit gnome2 eutils

DESCRIPTION="A GTK+2 giFT frontend"
HOMEPAGE="http://giftui.sourceforge.net/"
SRC_URI="mirror://sourceforge/giftui/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4.3
	net-p2p/gift
	>=gconf-2.6.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/main.c.diff
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make DESTDIR=${D} install || die
}
