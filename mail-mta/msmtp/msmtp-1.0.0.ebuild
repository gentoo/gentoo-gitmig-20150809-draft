# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.0.0.ebuild,v 1.3 2004/06/22 17:28:05 kugelfang Exp $

# msmtp *must* be built with TLS/SSL support, so the "ssl" USE flag cannot be
# used.
#
# It uses the "gnutls" USE flag (currently only used by net-libs/libsoup,
# described in profiles/use.local.desc) to determine whether to use GnuTLS or
# OpenSSL.
#
# It can use GNU SASL, but that is still in alpha stage and not yet in portage.

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
IUSE="gnutls"
DEPEND="!gnutls? ( dev-libs/openssl )
		gnutls?  ( >=net-libs/gnutls-1.0.0 )"
# sasl? ( net-libs/gsasl )
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

src_compile () {
	local myconf
	myconf="--disable-gsasl"
	# use sasl && myconf="${myconf} --enable-gsasl" 
	#	|| myconf="${myconf} --disable-gsasl"
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
