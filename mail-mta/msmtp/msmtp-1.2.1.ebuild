# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.2.1.ebuild,v 1.1 2004/08/01 20:40:10 slarti Exp $

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
IUSE="ssl gnutls sasl"
DEPEND="ssl? (
			gnutls?	( >=net-libs/gnutls-1.0.0 )
			!gnutls?  ( dev-libs/openssl )
		)
		sasl? ( virtual/gsasl )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

src_compile () {
	local myconf
	use sasl \
		&& myconf="${myconf} --enable-gsasl" \
		|| myconf="${myconf} --disable-gsasl"

	if [[ `use ssl` && `use gnutls` ]]; then
		myconf="${myconf} --enable-ssl --with-ssl=gnutls"
	elif [[ `use ssl` && !`use gnutls` ]]; then
		myconf="${myconf} --enable-ssl --with-ssl=openssl"
	else
		myconf="${myconf} --disable-ssl"
	fi

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install () {
	einstall || die "install failed"

	if [[ !`use ssl` && `use gnutls` ]]; then
		ewarn " "
		ewarn "gnutls support was not enabled (even though it was in your USE flags) as"
		ewarn "ssl was not in them also."
		ewarn " "
	fi

	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS \
		doc/msmtprc.example doc/Mutt+msmtp.txt || die "dodoc failed"
}
