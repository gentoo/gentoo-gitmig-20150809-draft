# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus/nessus-2.2.9.ebuild,v 1.1 2007/04/03 14:35:04 vanquirius Exp $

DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.nessus.org/"
DEPEND="~net-analyzer/nessus-libraries-${PV}
	~net-analyzer/libnasl-${PV}
	~net-analyzer/nessus-core-${PV}
	~net-analyzer/nessus-plugins-${PV}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

pkg_postinst() {
	einfo "The following article may be useful to get started:"
	einfo "http://www.securityfocus.com/infocus/1741"
}

pkg_postrm() {
	einfo "Note: this is a META ebuild for ${P}."
	einfo "to remove it completely or before re-emerging"
	einfo "either use 'depclean', or remove/re-emerge these packages:"
	echo
	for dep in ${RDEPEND}; do
		einfo "     ${dep}"
	done
	echo
}

