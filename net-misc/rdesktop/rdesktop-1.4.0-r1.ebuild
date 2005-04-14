# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.4.0-r1.ebuild,v 1.1 2005/04/14 12:59:07 wolf31o2 Exp $

inherit eutils

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~ia64 ~ppc64 ~amd64 ~ppc-macos"
IUSE="ssl debug ipv6 oss"

DEPEND="virtual/x11
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_unpack() {
	unpack ${A}
	# Patch provided by Richard Brown <mynamewasgone@gmail.com> to bug #88684
	epatch ${FILESDIR}/${P}-configure-with_arg.patch
}

src_compile() {
	local myconf
	if use ssl
	then
		myconf="--with-openssl=/usr"
	else
		myconf="--without-openssl"
	fi

	sed -i -e '/-O2/c\' -e 'cflags="$cflags ${CFLAGS}"' configure

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		`use_with debug` \
		`use_with ipv6` \
		`use_with oss sound` \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc COPYING doc/HACKING doc/TODO doc/keymapping.txt
}
