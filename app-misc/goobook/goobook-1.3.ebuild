# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/goobook/goobook-1.3.ebuild,v 1.1 2010/08/29 18:55:48 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
inherit distutils

DESCRIPTION="Google Contacts wrapper for mutt"
HOMEPAGE="http://code.google.com/p/goobook/"
SRC_URI="mirror://pypi/g/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/gdata
	dev-python/argparse
	=dev-python/hcs-utils-1.1.1
	dev-python/simplejson"

RESTRICT_PYTHON_ABIS="3.*"

pkg_postinst() {
	distutils_pkg_postinst

	einfo "If you want to use goobook from mutt"
	einfo "add this in your .muttrc file:"
	einfo "set query_command=\"goobook query '%s'\""
	einfo "to query address book."
	einfo
	einfo "You may find more information and advanced configuration tips at"
	einfo "http://pypi.python.org/pypi/${PN}/${PV} in \"Configure/Mutt\" section"
}
