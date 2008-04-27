# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac-webadmin/trac-webadmin-0.1.2-r1.ebuild,v 1.2 2008/04/27 12:42:16 maekke Exp $

inherit distutils eutils

DESCRIPTION="A Trac plugin for administering Trac projects through the web interface."
HOMEPAGE="http://projects.edgewall.com/trac/wiki/WebAdmin"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="trac"
KEYWORDS="amd64 ~ppc64 x86"
IUSE=""

SLOT="0"

DEPEND="=www-apps/trac-0.10*
	>=dev-python/setuptools-0.6_rc1"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}"/${P}-template.patch
	epatch "${FILESDIR}"/${P}-page_order.patch
}

src_install() {
	distutils_src_install --single-version-externally-managed
}

src_test() {
	"${python}" setup.py test || die "tests failed"
}

pkg_postinst() {
	elog "To enable the WebAdmin plugin in your Trac environments, you have to add:"
	elog "    [components]"
	elog "    webadmin.* = enabled"
	elog "to your trac.ini files."
	elog
	elog "To be able to see the Admin tab, your users must have the TRAC_ADMIN permission"
	elog "and/or the TICKET_ADMIN permission."
}
