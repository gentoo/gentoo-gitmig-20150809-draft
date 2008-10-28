# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porticron/porticron-0.1.ebuild,v 1.1 2008/10/28 12:17:34 hollow Exp $

DESCRIPTION="porticron is a cron script to sync portage and send update mails to root"
HOMEPAGE="http://www.gentoo.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-dns/bind-tools"

src_install() {
	insinto /etc/cron.daily
	newins "${FILESDIR}"/porticron-0.1 porticron
}
