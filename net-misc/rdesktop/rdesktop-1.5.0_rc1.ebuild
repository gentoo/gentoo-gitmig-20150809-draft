# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.5.0_rc1.ebuild,v 1.1 2006/07/05 16:14:52 wolf31o2 Exp $

inherit eutils

MY_PV=${PV/_/-}

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"
SRC_URI="http://www.rdesktop.org/files/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="debug ipv6 oss"

S=${WORKDIR}/${PN}-${MY_PV}

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
