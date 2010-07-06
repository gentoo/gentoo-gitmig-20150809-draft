# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/etc-proposals/etc-proposals-1.4.3-r1.ebuild,v 1.2 2010/07/06 17:58:20 arfrever Exp $

EAPI=2

PYTHON_DEPEND="2:2.5"

inherit distutils

DESCRIPTION="a set of tools for updating gentoo config files"
HOMEPAGE="http://developer.berlios.de/projects/etc-proposals/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

IUSE="gtk qt4"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="gtk? ( >=dev-python/pygtk-2.10 )
		qt4? ( >=dev-python/PyQt4-4.1.1[X] )"
RDEPEND="${DEPEND}"

src_install(){
	distutils_src_install
	dosbin "${D}"/usr/bin/etc-proposals
	rm -rf "${D}"/usr/bin
}

pkg_postinst() {
	elog "The configuration file has been installed to /etc/etc-proposals.conf"
	elog "If you are installing etc-proposals for the first time or updating"
	elog "from a version < 1.3 you should run the following command once:"
	elog "etc-proposals --init-db"
	ewarn "A full backup of /etc and other files managed by CONFIG_PROTECT"
	ewarn "is highly advised before testing this tool!"
}
