# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/neon/neon-0.21.1.ebuild,v 1.1 2002/06/06 20:55:28 stroke Exp $

S=${WORKDIR}/${P}

DESCRIPTION="HTTP and WebDAV client library"

SRC_URI="http://www.webdav.org/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.webdav.org/neon"
LICENSE="GPL-2"
DEPEND="dev-libs/libxml2
		ssl? ( >=dev-libs/openssl-0.9.6 )"

RDEPEND="${DEPEND}"
SLOT="0"


src_compile() {
	local myconf

	myconf='--enable-shared'

	use ssl && myconf="$myconf --with-ssl"
	
	econf $myconf || die 
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO doc/*
}

