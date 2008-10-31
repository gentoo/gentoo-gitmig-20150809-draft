# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porticron/porticron-0.2.ebuild,v 1.1 2008/10/31 08:20:07 hollow Exp $

DESCRIPTION="porticron is a cron script to sync portage and send update mails to root"
HOMEPAGE="http://git.xnull.de/gitweb/?p=porticron.git;a=summary"
SRC_URI="http://dev.gentoo.org/~hollow/distfiles/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-dns/bind-tools"

S="${WORKDIR}"/${PN}

src_install() {
	dosbin bin/porticron
	insinto /etc
	doins etc/porticron.conf
	insinto /etc/cron.daily
	doins "${FILESDIR}"/porticron
}
