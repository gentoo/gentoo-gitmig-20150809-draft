# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailer-config/mailer-config-0.2.ebuild,v 1.3 2007/06/12 12:36:27 genone Exp $

DESCRIPTION="Utility to switch between mailers using mailwrapper"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa"
IUSE=""

DEPEND=""

src_install() {
	dosbin  mailer-config
	dodoc README

	insinto /etc/mail/
	newins "${FILESDIR}/mailer.conf" default.mailer
}

pkg_postinst() {
	elog
	elog "Because /etc/mail/mailer.conf is now handled for you, it will"
	elog "save time if you add:"
	elog "    CONFIG_PROTECT_MASK=\"/etc/mail/mailer.conf\""
	elog "to your /etc/make.conf file."
	elog
	elog "With this, when a new profile is installed, it will be switched to"
	elog "automatically, and you will not be prompted to etc-update"
	elog "mailer.conf manually. Instead, you should always use mailer-config."
	elog
}
