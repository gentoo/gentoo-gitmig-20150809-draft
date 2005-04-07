# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.4.0.ebuild,v 1.1 2005/04/07 11:57:27 slarti Exp $

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/msmtp/${P}.tar.bz2"
IUSE="ssl gnutls sasl mailwrapper"
DEPEND="virtual/libc
	dev-util/pkgconfig
	ssl? (
		gnutls?	( >=net-libs/gnutls-1.2.0 )
		!gnutls?  ( >=dev-libs/openssl-0.9.6 )
	)
	sasl? ( >=virtual/gsasl-0.2.4 )
	mailwrapper? ( >=net-mail/mailwrapper-0.2 )
	!mailwrapper? ( !virtual/mta )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
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
		$(use_enable sasl gsasl) \
		${myconf} \
	|| die "configure failed"

	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} docdir=${D}/usr/share/doc docdirname=${P} install || die "install failed"

	if use mailwrapper; then
		insinto /etc/mail
		doins ${FILESDIR}/mailer.conf
	else
		dodir /usr/sbin /usr/lib
		dosym /usr/bin/msmtp /usr/sbin/sendmail || die "dosym failed"
		dosym /usr/sbin/sendmail /usr/lib/sendmail || die "dosym failed"
	fi

	dodoc AUTHORS ChangeLog NEWS README THANKS doc/msmtprc.example \
		doc/Mutt+msmtp.txt doc/msmtprc.example README.gsasl \
		doc/msmtprc-system.example doc/msmtprc-user.example \
	|| die "dodoc failed"

	if use doc; then
		dohtml doc/msmtp.html || die "dohtml failed"
		insinto /usr/share/doc/${PF}
		doins doc/msmtp.pdf
	fi
}
