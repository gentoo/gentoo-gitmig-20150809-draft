# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icecast/icecast-1.3.12-r1.ebuild,v 1.4 2003/01/09 21:29:05 vapier Exp $

DESCRIPTION="Internet based broadcasting system based on the mpeg3 streaming technology"
SRC_URI="http://www.icecast.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org/"

KEYWORDS="x86 -ppc sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE="crypt"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/variables.diff || die
}

src_compile() {
	./configure \
		`use_with crypt` \
		--with-libwrap \
		--prefix=/usr \
		--sysconfdir=/etc/icecast \
		--localstatedir=/var \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--host=${CHOST} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} \
		ICECAST_BINDIR=/usr/bin \
		ICECAST_DOCDIR=/usr/share/doc/${P} \
		ICECAST_ETCDIR=/etc/icecast \
		ICECAST_ETCDIR_INST=/etc/icecast \
		ICECAST_LOGDIR=/var/log/icecast \
		ICECAST_LOGDIR_INST=/var/log/icecast \
		ICECAST_SBINDIR=/usr/sbin \
		ICECAST_STATICDIR=/usr/share/icecast/static \
		ICECAST_STATICDIR_INST=/usr/share/icecast/static \
        	ICECAST_TEMPLATEDIR=/usr/share/icecast/templates \
		ICECAST_TEMPLATEDIR_INST=/usr/share/icecast/templates \
		install || die "make install failed"
	dodoc AUTHORS BUGS CHANGES COPYING FAQ INSTALL README TESTED TODO
}
