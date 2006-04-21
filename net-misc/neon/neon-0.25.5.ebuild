# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/neon/neon-0.25.5.ebuild,v 1.3 2006/04/21 03:41:51 flameeyes Exp $

inherit libtool

DESCRIPTION="HTTP and WebDAV client library"
HOMEPAGE="http://www.webdav.org/neon/"
SRC_URI="http://www.webdav.org/neon/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="ssl zlib expat"
# socks5

DEPEND="expat? ( dev-libs/expat )
	!expat? ( dev-libs/libxml2 )
	ssl? ( >=dev-libs/openssl-0.9.6f )
	zlib? ( sys-libs/zlib )"

# gnutls not supported yet
#	gnutls? ( net-libs/gnutls )
#	!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6f ) )

src_unpack() {
	unpack ${A}
	if use userland_Darwin ; then
		sed -i -e "s:GXX:GCC:g" ${S}/configure || die "sed failed"
	fi

	elibtoolize
}

src_compile() {
	local myc=""
	use expat && myc="${myc} --with-expat" || myc="${myc} --with-xml2"

#	if use gnutls
#	then
#		myc="${myc} --with-ssl=gnutls"
#	else
#		myc="${myc} $(use_with ssl ssl openssl)"
#	fi

#	Socks5 not quite there yet
#		$(use_enable socks5 socks) \

	econf \
		--enable-shared \
		--without-gssapi \
		$(use_with zlib) \
		$(use_with ssl) \
		${myc} \
		|| die "econf failed"
	emake || die 'make failed'
}

src_install() {
	make DESTDIR=${D} install || die 'install failed'
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO doc/*
}
