# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.9.3-r3.ebuild,v 1.1 2004/10/19 12:23:45 absinthe Exp $

inherit eutils

LICENSE="GPL-2"
DESCRIPTION="An ICQ v8 Client. Supports File Transfer, Chat, Server-Side Contactlist, ..."
SRC_URI="mirror://sourceforge/sim-icq/${P}-2.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://sim-icq.sourceforge.net"
KEYWORDS="~x86 ~ppc ~amd64"
SLOT="0"
IUSE="ssl kde debug"

RDEPEND="ssl? ( dev-libs/openssl )
	kde? ( kde-base/kdebase )
	!kde? ( x11-libs/qt )
	app-text/sablotron
	sys-devel/flex
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.5
	dev-libs/libxslt"

src_compile() {
	epatch ${FILESDIR}/${P}-gcc34.diff
	epatch ${FILESDIR}/${P}-alt-histpreview-apply-fix.diff
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7

	addwrite "${QTDIR}/etc/settings"

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
