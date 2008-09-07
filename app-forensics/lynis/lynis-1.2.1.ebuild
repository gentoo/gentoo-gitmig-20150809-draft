# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/lynis/lynis-1.2.1.ebuild,v 1.1 2008/09/07 13:10:59 bluebird Exp $

DESCRIPTION="Security and system auditing tool"
HOMEPAGE="http://www.rootkit.nl/projects/lynis.html"
SRC_URI="http://www.rootkit.nl/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

src_install() {
	insinto /usr/share/lynis/db
	doins db/*.db || die "failed to install lynis db files"

	insinto /usr/share/lynis/include
	doins include/* || die "failed to install lynis includes"

	insinto /usr/share/lynis/plugins
	doins plugins/* || die "failed to install lynis plugins"

	dobin lynis || die "failed to install lynis script"

	insinto /etc/lynis
	doins default.prf || die "failed to install default.prf"
	keepdir /etc/lynis

	doman lynis.8 || die "doman failed"
	dodoc CHANGELOG README INSTALL FAQ TODO || die "dodoc failed"

	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/lynis.cron lynis || die "failed to install cron script"
}

pkg_postinst() {
	echo
	elog "A cron script has been installed to ${ROOT}etc/cron.daily/lynis."
	echo
}
