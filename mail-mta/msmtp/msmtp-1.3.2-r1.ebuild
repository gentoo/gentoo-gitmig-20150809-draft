# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.3.2-r1.ebuild,v 1.3 2005/02/07 06:54:11 ticho Exp $

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
IUSE="ssl gnutls sasl mailwrapper"
DEPEND="virtual/libc
	dev-util/pkgconfig
	ssl? (
		gnutls?	( >=net-libs/gnutls-1.0.0 )
		!gnutls?  ( >=dev-libs/openssl-0.9.6 )
	)
	sasl? ( >=virtual/gsasl-0.2.3 )
	mailwrapper? ( >=net-mail/mailwrapper-0.2 )
	!mailwrapper? ( !virtual/mta )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64"
PROVIDE="virtual/mta"

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

	if use mailwrapper; then
		insinto /etc/mail
		doins ${FILESDIR}/mailer.conf
	else
		dodir /usr/sbin /usr/lib
		dosym /usr/bin/msmtp /usr/sbin/sendmail || die "dosym failed"
		dosym /usr/sbin/sendmail /usr/lib/sendmail || die "dosym failed"
	fi


	dodoc AUTHORS ChangeLog NEWS README THANKS \
		doc/msmtprc.example doc/Mutt+msmtp.txt \
		doc/msmtprc.example README.gsasl \
		|| die "dodoc failed"
}
