# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.4.1.ebuild,v 1.15 2006/04/14 11:44:59 wolf31o2 Exp $

inherit eutils

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~mips ppc ppc-macos ppc64 sparc x86 hppa"
IUSE="debug ipv6 oss"

RDEPEND="|| (
	(
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXau
		x11-libs/libXdmcp )
	virtual/x11 )
	>=dev-libs/openssl-0.9.6b"
DEPEND="${RDEPEND}
	|| (
		x11-libs/libXt
		virtual/x11 )"

src_compile() {
	sed -i -e '/-O2/c\' -e 'cflags="$cflags ${CFLAGS}"' configure
	sed -i -e 's:strip:true:' Makefile.in
	econf \
		--with-openssl=/usr \
		`use_with debug` \
		`use_with ipv6` \
		`use_with oss sound` \
		|| die

	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc COPYING doc/HACKING doc/TODO doc/keymapping.txt
}
