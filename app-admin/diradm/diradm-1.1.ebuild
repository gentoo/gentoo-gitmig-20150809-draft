# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/diradm/diradm-1.1.ebuild,v 1.8 2005/01/01 10:58:21 eradicator Exp $

DESCRIPTION="diradm is for managing posix users/groups in an LDAP directory"
HOMEPAGE="http://www.hits.at/diradm/"
SRC_URI="http://www.hits.at/diradm/diradm-1.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="net-nds/openldap
	sys-apps/coreutils
	sys-apps/grep
	sys-apps/sed"

src_install() {
	dosbin diradm || die

	insinto /etc
	doins diradm.conf

	dodoc CHANGES README
}

pkg_postinst() {
	einfo "Don't forget to customize /etc/diradm.conf for your LDAP schema"
}
