# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/nbsmtp/nbsmtp-0.99-r1.ebuild,v 1.2 2005/06/15 09:28:04 ferdy Exp $

inherit eutils mailer

DESCRIPTION="Extremely simple MTA to get mail off the system to a relayhost"
SRC_URI="http://www.gentoo-es.org/~ferdy/${P}.tar.bz2"
HOMEPAGE="http://nbsmtp.ferdyx.org"

SLOT="0"
KEYWORDS="~x86 ~ppc ~hppa ~amd64 ~sparc ~alpha"
LICENSE="GPL-2"
IUSE="ssl ipv6 debug"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

src_compile() {
	local myconf

	epatch ${FILESDIR}/${PN}-CRAM-MD5.diff

	econf $(use_enable ssl) \
		$(use_enable debug) \
		$(use_enable ipv6) \
		${myconf} || die

	make || die
}

src_install() {
	dodir /usr/bin /usr/sbin /usr/lib
	dobin nbsmtp
	doman nbsmtprc.5 nbsmtp.8
	dodoc INSTALL DOCS Doxyfile

	dobin scripts/wrapper-nbsmtp
	dobin scripts/nbqueue

	if use mailwrapper ; then
		dohard /usr/bin/wrapper-nbsmtp /usr/bin/sendmail.nbsmtp
		dohard /usr/bin/wrapper-nbsmtp /usr/bin/mailq.nbsmtp
		dohard /usr/bin/wrapper-nbsmtp /usr/bin/newaliases.nbsmtp
		mailer_install_conf
	else
		dohard /usr/bin/wrapper-nbsmtp /usr/bin/sendmail
		dohard /usr/bin/wrapper-nbsmtp /usr/sbin/sendmail
		dohard /usr/bin/wrapper-nbsmtp /usr/lib/sendmail
		dohard /usr/bin/wrapper-nbsmtp /usr/bin/mailq
		dohard /usr/bin/wrapper-nbsmtp /usr/bin/newaliases
	fi
}
