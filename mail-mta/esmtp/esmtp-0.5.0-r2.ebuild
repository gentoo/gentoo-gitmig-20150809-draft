# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/esmtp/esmtp-0.5.0-r2.ebuild,v 1.2 2005/05/12 17:28:32 ferdy Exp $

inherit mailer

DESCRIPTION="esmtp is a user configurable relay-only Mail Transfer Agent (MTA) with a sendmail compatible syntax"
HOMEPAGE="http://esmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
DEPEND="virtual/libc
	net-libs/libesmtp
	dev-libs/openssl"

src_install() {
	make DESTDIR=${D} install || die "einstall failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	if use mailwrapper ; then
		mv ${D}/usr/sbin/sendmail ${D}/usr/bin/sendmail.esmtp
		mv ${D}/usr/bin/mailq ${D}/usr/bin/mailq.esmtp
		mv ${D}/usr/bin/newaliases ${D}/usr/bin/newaliases.esmtp
		mailer_install_conf
	fi
}
