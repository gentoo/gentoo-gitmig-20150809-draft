# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/filewatcher/filewatcher-2.4.3.ebuild,v 1.3 2007/01/24 14:15:05 genone Exp $

DESCRIPTION="This is a configuration file control system and IDS"
HOMEPAGE="http://www.willingminds.com/resources/filewatcher.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-perl/MailTools
	app-text/rcs
	virtual/mta"

src_install() {
	keepdir /var/lib/filewatcher /var/lib/filewatcher/archive
	dosbin filewatcher || die "could not install filewatcher"
	doman filewatcher.1 || die "could not install filewatcher manpage"

	dodoc Changes README

	insinto /etc
	doins "${FILESDIR}"/filewatcher.conf || \
		die "could not install basic filewatcher config"
}

pkg_postinst() {
	elog " A basic configuration has been provided in"
	elog " /etc/filewatcher.conf.  It is strongly"
	elog " recommended that you invoke filewatcher via"
	elog " crontab."
	elog
	elog " 55,25,40 * * * * root /usr/sbin/filewatcher"
	elog " --config=/etc/filewatcher.conf"
}
