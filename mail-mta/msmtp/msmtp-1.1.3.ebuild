# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.1.3.ebuild,v 1.1 2004/07/10 16:55:17 slarti Exp $

# msmtp *must* be built with TLS/SSL support, so the "ssl" USE flag cannot be
# used.

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
IUSE="gnutls sasl"
DEPEND="gnutls?  ( >=net-libs/gnutls-1.0.0 )
		!gnutls? ( dev-libs/openssl )
		sasl?	 ( virtual/gsasl )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

src_compile () {
	local myconf
	use sasl \
		&& myconf="${myconf} --enable-gsasl" \
		|| myconf="${myconf} --disable-gsasl"
	use gnutls \
		&& myconf="${myconf} --with-ssl=gnutls" \
		|| myconf="${myconf} --with-ssl=openssl"
	econf ${myconf} || die "configure failed"
	make || die "make failed"
}

src_install () {
	einstall || die "install failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS \
		doc/msmtprc.example doc/Mutt+msmtp.txt || die "dodoc failed"
}
