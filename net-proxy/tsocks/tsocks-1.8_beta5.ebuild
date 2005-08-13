# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/tsocks/tsocks-1.8_beta5.ebuild,v 1.6 2005/08/13 23:00:24 hansmi Exp $

inherit multilib

DESCRIPTION="Transparent SOCKS v4 proxying library"
HOMEPAGE="http://tsocks.sourceforge.net/"
SRC_URI="mirror://sourceforge/tsocks/${PN}-${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
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
		--libdir=/$(get_libdir) \
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
	dodir /usr/$(get_libdir)
	dosym /$(get_libdir)/libtsocks.so /usr/$(get_libdir)/libtsocks.so
}

pkg_postinst() {
	einfo "Make sure you create /etc/socks/tsocks.conf from one of the examples in that directory"
}
