# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tsocks/tsocks-1.8_beta4.ebuild,v 1.9 2003/06/12 21:54:33 msterret Exp $

DESCRIPTION="Transparent SOCKS v4 proxying library."
HOMEPAGE="http://tsocks.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
SRC_URI="http://ftp1.sourceforge.net/${PN}/${PN}-1.8beta4.tar.gz"
KEYWORDS="x86 sparc "
SLOT="0"

S=${WORKDIR}/tsocks-1.8

src_compile() {
	# NOTE: the docs say to install it into /lib. If you put it into
	# /usr/lib and add it to /etc/ld.so.preload on many systems /usr isn't
	# mounted in time :-( (Ben Lutgens) <lamer@gentoo.org> 
	try ./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-conf=/etc/socks/tsocks.conf \
		--mandir=/usr/share/man
	try emake
}

src_install () {
	make DESTDIR=${D} install || die
	dobin validateconf inspectsocks saveme
	insinto /etc/socks
	doins tsocks.conf.*.example
	dodoc INSTALL
	# tsocks script is buggy so we need this symlink
	dodir /usr/lib
	dosym /lib/libtsocks.so /usr/lib/libtsocks.so
}

pkg_postinst () {
	einfo "Make sure you create /etc/socks/tsocks.conf from on of the
	examples in that directory"
}
