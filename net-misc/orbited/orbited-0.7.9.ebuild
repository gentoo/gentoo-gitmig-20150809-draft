# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/orbited/orbited-0.7.9.ebuild,v 1.1 2009/04/19 12:36:09 caleb Exp $

inherit distutils

DESCRIPTION="Real-time communication for the browser."
HOMEPAGE="http://orbited.org"
SRC_URI="http://pypi.python.org/packages/source/o/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/twisted
	>=dev-python/morbid-0.8.4
	dev-python/demjson
	dev-python/stomper
	>=dev-python/uuid-1.2"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
	mkdir -p "${D}/etc"
	cp "${FILESDIR}/${PV}/orbited.cfg" "${D}/etc/orbited.cfg" || die "couldn't create config file"
	newinitd "${FILESDIR}/${PV}/orbited.init" orbited
}

