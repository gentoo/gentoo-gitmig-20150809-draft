# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paver/paver-1.0.1.ebuild,v 1.2 2009/12/24 17:11:58 pacho Exp $

EAPI="2"

inherit distutils

MY_PN="${PN/p/P}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python-based software project scripting tool along the lines of Make"
HOMEPAGE="http://www.blueskyonmars.com/projects/paver/"
SRC_URI="http://pypi.python.org/packages/source/P/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	# overriding default functions as --no_compile option is not supported
	${python} setup.py install --root="${D}" "$@" || die "install failed"

	dodoc README.txt || die "dodoc failed"
}
