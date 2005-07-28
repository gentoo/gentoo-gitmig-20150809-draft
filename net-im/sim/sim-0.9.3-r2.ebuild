# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.9.3-r2.ebuild,v 1.11 2005/07/28 20:58:47 caleb Exp $

inherit kde-functions

LICENSE="GPL-2"
DESCRIPTION="An ICQ v8 Client. Supports File Transfer, Chat, Server-Side Contactlist, ..."
SRC_URI="mirror://sourceforge/sim-icq/${P}-2.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://sim-icq.sourceforge.net"
KEYWORDS="x86 ~ppc ~amd64"
SLOT="0"
IUSE="ssl kde debug"

RDEPEND="ssl? ( dev-libs/openssl )
	kde? ( || ( kde-base/kdebase-meta kde-base/kdebase ) )
	!kde? ( =x11-libs/qt-3* )
	app-text/sablotron
	sys-devel/flex
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.5
	dev-libs/libxslt"

src_compile() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7

	set-qtdir 3
	set-kdedir 3

	make -f admin/Makefile.common

	econf `use_enable ssl openssl` \
		`use_enable kde` \
		`use_enable debug` || die "econf failed"

	make clean  || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc TODO README ChangeLog COPYING AUTHORS
}
