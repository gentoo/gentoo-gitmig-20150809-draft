# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/diradm/diradm-1.2.ebuild,v 1.5 2005/08/12 03:24:42 robbat2 Exp $

DESCRIPTION="diradm is for managing posix users/groups in an LDAP directory"
HOMEPAGE="http://www.hits.at/${PN}/"
SRC_URI="http://www.hits.at/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
RDEPEND="net-nds/openldap
	sys-apps/coreutils
	sys-apps/grep
	sys-apps/sed"
DEPEND=""

src_install() {
	dosbin diradm || die

	insinto /etc
	doins diradm.conf

	dodoc CHANGES README
}

pkg_postinst() {
	einfo "Don't forget to customize /etc/diradm.conf for your LDAP schema"
}
