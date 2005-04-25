# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailer-config/mailer-config-0.1.ebuild,v 1.3 2005/04/25 18:42:50 ferdy Exp $

DESCRIPTION="Utility to switch between mailers using mailwrapper"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa"
IUSE=""

DEPEND=""

src_install() {
	dobin  mailer-config
	dodoc README

	insinto /etc/mail/
	newins "${FILESDIR}/mailer.conf" default.mailer
}
