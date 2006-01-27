# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/esmtp/esmtp-0.5.1.ebuild,v 1.3 2006/01/27 14:29:41 slarti Exp $

inherit mailer

DESCRIPTION="esmtp is a user configurable relay-only Mail Transfer Agent (MTA) with a sendmail compatible syntax"
HOMEPAGE="http://esmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="virtual/libc
	net-libs/libesmtp
	dev-libs/openssl"

src_install() {
	make DESTDIR=${D} install || die "einstall failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	if use mailwrapper ; then
		rm "${D}/usr/sbin/sendmail"
		rm "${D}/usr/lib/sendmail"
		dosym "/usr/bin/esmtp" "/usr/sbin/sendmail.esmtp"
		rm "${D}/usr/bin/mailq"
		rm "${D}/usr/bin/newaliases"
		mv "${D}/usr/share/man/man1/newaliases.1" \
			"${D}/usr/share/man/man1/newaliases-esmtp.1"
		mv "${D}/usr/share/man/man1/mailq.1" \
			"${D}/usr/share/man/man1/mailq-esmtp.1"
		mv "${D}/usr/share/man/man1/sendmail.1" \
			"${D}/usr/share/man/man1/sendmail-esmtp.1"
		mailer_install_conf
	fi
}
