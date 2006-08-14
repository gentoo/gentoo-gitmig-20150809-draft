# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/yasuc/yasuc-0.4.1.ebuild,v 1.1 2006/08/14 19:36:49 nelchael Exp $

IUSE=""

DESCRIPTION="Uptime Client for www.uptime-project.net"
SRC_URI="x86? ( http://www.i-glyphix.net/files/${P}_x86_linux.tar.bz2 )
	amd64? ( http://www.i-glyphix.net/files/${P}_x86-64_linux.tar.bz2 )"
HOMEPAGE="http://www.uptime-project.net"

LICENSE="as-is"
KEYWORDS="~x86 ~amd64 -*"
SLOT="0"

S="${WORKDIR}/dist/${P}"

src_install() {
	dobin ${PN}

	insinto /etc
	insopts -m0600
	doins ${PN}.conf

	dodoc README
}

pkg_postinst() {
	einfo "Don't forget to edit /etc/yasuc.conf"
	einfo "and add a cronjob (e.g. \"crontab -e\")"
}
