# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-5.9.6.ebuild,v 1.2 2002/07/11 06:30:47 drobbins Exp $

DESCRIPTION="Fetchmail is a full-featured remote-mail retrieval and forwarding utility"
HOMEPAGE="http://www.tuxedo.org/~esr/fetchmail/"
SRC_URI="http://www.tuxedo.org/~esr/fetchmail/${P}.tar.gz"
S=${WORKDIR}/${P}
        
DEPEND="virtual/glibc ssl? ( >=dev-libs/openssl-0.9.6 ) nls? ( sys-devel/gettext )"

src_compile() {

	local myconf
	use ssl && myconf="${myconf} --with-ssl=/usr"
	use nls || myconf="${myconf} --disable-nls"
	# This needs inet6-apps, which we don't have
	#use ipv6 && myconf="{myconf} --enable-inet6"

	./configure \
	--enable-RPA \
	--enable-NTLM \
	--enable-SDPS \
	--prefix=/usr \
	--mandir=/usr/share/man \
	--infodir=/usr/share/info \
	--host=${CHOST} ${myconf} || die "bad configure"

	emake || die "compile problem"
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc FAQ FEATURES ABOUT-NLS NEWS NOTES README
	dodoc README.NTLM README.SSL TODO COPYING MANIFEST
	docinto html ; dodoc *.html
	docinto contrib ; dodoc contrib/*
}
