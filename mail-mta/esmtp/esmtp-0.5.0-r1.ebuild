# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/esmtp/esmtp-0.5.0-r1.ebuild,v 1.5 2004/11/01 21:18:38 ticho Exp $

DESCRIPTION="esmtp is a user configurable relay-only Mail Transfer Agent (MTA) with a sendmail compatible syntax"
HOMEPAGE="http://esmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="mailwrapper"
DEPEND="virtual/libc
	net-libs/libesmtp
	dev-libs/openssl"
RDEPEND="${DEPEND}
	mailwrapper? ( >=net-mail/mailwrapper-0.2 )
	!mailwrapper? ( !virtual/mta )"
PROVIDE="virtual/mta"

src_install() {
	make DESTDIR=${D} install || die "einstall failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	if use mailwrapper
	then
		# We install sendmail binary to be compatible with mailwrapper
		mv ${D}/usr/sbin/sendmail ${D}/usr/sbin/sendmail.esmtp
		mv ${D}/usr/lib/sendmail ${D}/usr/lib/sendmail.esmtp
	fi
}
