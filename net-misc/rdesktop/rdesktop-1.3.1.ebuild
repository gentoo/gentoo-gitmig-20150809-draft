# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.3.1.ebuild,v 1.10 2004/07/19 02:31:32 tgall Exp $

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ia64 ppc64"
IUSE="ssl debug"

DEPEND="virtual/x11
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_unpack() {
	unpack ${A}
}

src_compile() {
	local myconf
	use ssl \
		&& myconf="--with-openssl=/usr/include/openssl" \
		|| myconf="--without-openssl"

	sed -i -e '/-O2/c\' -e 'cflags="$cflags ${CFLAGS}"' configure

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sharedir=/usr/share/${PN} \
		`use_with debug` \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc COPYING doc/HACKING doc/TODO doc/keymapping.txt
}
