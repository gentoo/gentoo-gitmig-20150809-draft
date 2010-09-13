# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/orbited/orbited-0.7.10-r1.ebuild,v 1.1 2010/09/13 19:06:57 xmw Exp $

inherit distutils

DESCRIPTION="Real-time communication for the browser."
HOMEPAGE="http://orbited.org"
SRC_URI="mirror://pypi/o/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/twisted-web
	dev-python/twisted
	>=dev-python/morbid-0.8.4
	dev-python/demjson
	dev-python/stomper"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_install() {
	distutils_src_install
	insinto /etc
	doins "${FILESDIR}/orbited.cfg" || die
	newinitd "${FILESDIR}/orbited.init" orbited || die
}
