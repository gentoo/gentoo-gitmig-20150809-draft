# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.3.1.ebuild,v 1.2 2005/01/03 20:01:37 corsair Exp $

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
IUSE="ssl gnutls sasl"
DEPEND="virtual/libc
	dev-util/pkgconfig
	ssl? (
		gnutls?	( >=net-libs/gnutls-1.0.0 )
		!gnutls?  ( >=dev-libs/openssl-0.9.6 )
	)
	sasl? ( >=virtual/gsasl-0.2.3 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

src_compile () {
	local myconf

	if use ssl && use gnutls ; then
		myconf="${myconf} --enable-ssl --with-ssl=gnutls"
	elif use ssl && ! use gnutls ; then
		myconf="${myconf} --enable-ssl --with-ssl=openssl"
	else
		myconf="${myconf} --disable-ssl"
	fi

	econf \
		$(use_enable sasl) \
		${myconf} \
	|| die "configure failed"

	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS \
		doc/msmtprc.example doc/Mutt+msmtp.txt || die "dodoc failed"
}
