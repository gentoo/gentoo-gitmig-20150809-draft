# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/nbsmtp/nbsmtp-1.00-r3.ebuild,v 1.5 2010/07/08 16:42:16 hwoarang Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Extremely simple MTA to get mail off the system to a relayhost"
SRC_URI="http://www.gentoo-es.org/~ferdy/${P}.tar.bz2"
HOMEPAGE="http://nbsmtp.ferdyx.org"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
LICENSE="GPL-2"
IUSE="ssl ipv6 debug"

DEPEND="ssl? ( dev-libs/openssl )
	!virtual/mta"

PROVIDE="virtual/mta"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-openssl.patch
	sed -i \
		-e '/CFLAGS=/a\LDLIBS=@LIBS@' \
		-e '/$(CC) -o/d' \
		Makefile.in || die 'Failed to sed Makefile.in'
}

src_compile() {
	tc-export CC
	econf $(use_enable ssl) \
		$(use_enable debug) \
		$(use_enable ipv6) || die

	emake || die
}

src_install() {
	dodir /usr/{{s,}bin,lib}
	dobin nbsmtp
	dobin scripts/nbqueue
	dobin scripts/wrapper-nbsmtp
	doman nbsmtprc.5 nbsmtp.8
	dodoc INSTALL DOCS Doxyfile

	dohard /usr/bin/wrapper-nbsmtp /usr/bin/sendmail
	dohard /usr/bin/wrapper-nbsmtp /usr/sbin/sendmail
	dohard /usr/bin/wrapper-nbsmtp /usr/lib/sendmail
	dohard /usr/bin/wrapper-nbsmtp /usr/bin/mailq
	dohard /usr/bin/wrapper-nbsmtp /usr/bin/newaliases
}
