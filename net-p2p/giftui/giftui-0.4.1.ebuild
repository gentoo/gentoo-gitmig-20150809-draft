# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/giftui/giftui-0.4.1.ebuild,v 1.9 2004/11/30 22:30:32 swegener Exp $

inherit gnome2 eutils

DESCRIPTION="A GTK+2 giFT frontend"
HOMEPAGE="http://giftui.sourceforge.net/"
SRC_URI="mirror://sourceforge/giftui/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4.3
	net-p2p/gift
	>=gnome-base/gconf-2.6.0"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.8
	>=sys-devel/autoconf-2.58
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.patch
	sed -i -e 's:/doc/giftui:/share/doc/${P}:g' Makefile*
	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5
	autoconf || die
	automake || die
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make DESTDIR=${D} install || die
}
