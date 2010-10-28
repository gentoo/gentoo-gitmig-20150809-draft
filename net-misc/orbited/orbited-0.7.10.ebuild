# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/orbited/orbited-0.7.10.ebuild,v 1.4 2010/10/28 12:54:03 ssuominen Exp $

inherit distutils

DESCRIPTION="Real-time communication for the browser."
HOMEPAGE="http://orbited.org"
SRC_URI="mirror://pypi/o/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/twisted-web
	dev-python/twisted
	>=dev-python/morbid-0.8.4
	|| ( dev-python/simplejson dev-python/demjson )
	dev-python/stomper"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_install() {
	distutils_src_install
	insinto /etc
	doins "${FILESDIR}/orbited.cfg" || die "installing config file failed"
	newinitd "${FILESDIR}/orbited.init" orbited
}
