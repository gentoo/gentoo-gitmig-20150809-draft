# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/orbited/orbited-0.7.9.ebuild,v 1.5 2009/05/06 17:46:54 caleb Exp $

inherit distutils

DESCRIPTION="Real-time communication for the browser."
HOMEPAGE="http://orbited.org"
SRC_URI="http://pypi.python.org/packages/source/o/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/twisted-web
	dev-python/twisted
	>=dev-python/morbid-0.8.4
	dev-python/demjson
	dev-python/stomper
	>=dev-python/uuid-1.2"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_install() {
	distutils_src_install
	insinto /etc
	doins "${FILESDIR}/${PV}/orbited.cfg" || die "installing config file failed"
	newinitd "${FILESDIR}/${PV}/orbited.init" orbited
}
