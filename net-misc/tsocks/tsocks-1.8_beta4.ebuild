# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tsocks/tsocks-1.8_beta4.ebuild,v 1.16 2004/07/15 03:39:27 agriffis Exp $

DESCRIPTION="Transparent SOCKS v4 proxying library"
HOMEPAGE="http://tsocks.sourceforge.net/"
SRC_URI="mirror://sourceforge/tsocks/${PN}-${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha amd64"
IUSE=""

S=${WORKDIR}/tsocks-1.8

src_compile() {
	# NOTE: the docs say to install it into /lib. If you put it into
	# /usr/lib and add it to /etc/ld.so.preload on many systems /usr isn't
	# mounted in time :-( (Ben Lutgens) <lamer@gentoo.org>
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-conf=/etc/socks/tsocks.conf \
		--mandir=/usr/share/man \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dobin validateconf inspectsocks saveme
	insinto /etc/socks
	doins tsocks.conf.*.example
	dodoc INSTALL
	# tsocks script is buggy so we need this symlink
	dodir /usr/lib
	dosym /lib/libtsocks.so /usr/lib/libtsocks.so
}

pkg_postinst() {
	einfo "Make sure you create /etc/socks/tsocks.conf from on of the examples in that directory"
}
