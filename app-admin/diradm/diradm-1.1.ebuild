# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/diradm/diradm-1.1.ebuild,v 1.1 2003/07/05 08:52:49 robbat2 Exp $

DESCRIPTION="diradm is for managing posix users/groups in an LDAP directory"
HOMEPAGE="http://www.hits.at/diradm/"
SRC_URI="http://www.hits.at/diradm/diradm-1.1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-nds/openldap
		sys-apps/fileutils
		sys-apps/grep
		sys-apps/sed"

S=${WORKDIR}/${P}

src_install() {
	# Binary
	dobin diradm

	# Config file
	insinto /etc
	doins diradm.conf

	# Docs
	dodoc CHANGES COPYING README
}

pkg_postinst() {
	einfo "Don't forget to customize /etc/diradm.conf for your LDAP schema"
}
