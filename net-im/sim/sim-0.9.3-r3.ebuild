# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.9.3-r3.ebuild,v 1.5 2005/05/12 22:38:58 greg_g Exp $

inherit eutils kde-functions

DESCRIPTION="An ICQ v8 Client. Supports File Transfer, Chat, Server-Side Contactlist."
HOMEPAGE="http://sim-icq.sourceforge.net"
SRC_URI="mirror://sourceforge/sim-icq/${P}-2.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="ssl kde debug"

RDEPEND="x11-libs/qt
	kde? ( || ( kde-base/kdebase-data kde-base/kdebase ) )
	ssl? ( dev-libs/openssl )
	dev-libs/libxslt"
# kdebase-data provides the icon "licq.png"

DEPEND="${RDEPEND}
	sys-devel/flex
	=sys-devel/automake-1.7*
	=sys-devel/autoconf-2.5*"

src_compile() {
	epatch ${FILESDIR}/${P}-gcc34.diff
	epatch ${FILESDIR}/${P}-alt-histpreview-apply-fix.diff
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
	make DESTDIR="${D}" install || die
	dodoc TODO README ChangeLog AUTHORS
}
