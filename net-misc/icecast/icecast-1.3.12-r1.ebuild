# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icecast/icecast-1.3.12-r1.ebuild,v 1.8 2004/04/07 04:10:01 raker Exp $

inherit eutils

DESCRIPTION="Internet based broadcasting system based on the mpeg3 streaming technology"
HOMEPAGE="http://www.icecast.org/"
SRC_URI="http://www.icecast.org/releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc sparc"
IUSE="crypt"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-variables-gentoo.diff.bz2
	epatch ${FILESDIR}/${PV}-errno.patch
}

src_compile() {
	econf \
		`use_with crypt` \
		--with-libwrap \
		--sysconfdir=/etc/icecast \
		--localstatedir=/var \
		|| die "configure failed"
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
