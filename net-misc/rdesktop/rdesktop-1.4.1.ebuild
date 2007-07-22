# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.4.1.ebuild,v 1.18 2007/07/22 08:15:37 dberkholz Exp $

inherit eutils

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="debug ipv6 oss"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXau
	x11-libs/libXdmcp
	>=dev-libs/openssl-0.9.6b"
DEPEND="${RDEPEND}
	x11-libs/libXt"

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
