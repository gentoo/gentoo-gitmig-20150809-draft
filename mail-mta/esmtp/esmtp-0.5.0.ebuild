# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/esmtp/esmtp-0.5.0.ebuild,v 1.1 2004/09/03 00:54:43 ticho Exp $

DESCRIPTION="esmtp is a user configurable relay-only Mail Transfer Agent (MTA) with a sendmail compatible syntax"
HOMEPAGE="http://esmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc
	net-libs/libesmtp
	dev-libs/openssl"
RDEPEND="${DEPEND}
	>=net-mail/mailwrapper-0.2"

src_install() {
	make DESTDIR=${D} install || die "einstall failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	# We install sendmail binary to be compatible with mailwrapper
	mv ${D}/usr/sbin/sendmail ${D}/usr/sbin/sendmail.esmtp
	mv ${D}/usr/lib/sendmail ${D}/usr/lib/sendmail.esmtp
}

pkg_postinst() {
	echo
	einfo "esmtp on Gentoo supports mailwrapper (\`man mailwrapper\` for more info)."
	einfo "If you want to use esmtp's /usr/sbin/sendmail as your MTA, please set"
	einfo "up your mailer.conf accordingly."
	echo
}
