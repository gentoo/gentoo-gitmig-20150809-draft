# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/neon/neon-0.24.5.ebuild,v 1.5 2004/06/02 22:40:11 vapier Exp $

DESCRIPTION="HTTP and WebDAV client library"
HOMEPAGE="http://www.webdav.org/neon"
SRC_URI="http://www.webdav.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64 s390"
IUSE="ssl zlib expat"

DEPEND="expat? ( dev-libs/expat )
	!expat? ( dev-libs/libxml2 )
	ssl? ( >=dev-libs/openssl-0.9.6f )
	zlib? ( sys-libs/zlib )"

src_compile() {
	local myc='--enable-shared'

	use ssl && myc="$myc --with-ssl" || myc="$myc --without-ssl"
	use expat && myc="$myc --with-expat" || myc="$myc --with-xml2"
	use zlib && myc="$myc --with-zlib" || myc="$myc --without-zlib"

	econf $myc || die "econf failed"
	emake
}

src_install () {
	einstall
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO doc/*
}
