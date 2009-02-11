# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mantissa/mantissa-0.6.21.ebuild,v 1.2 2009/02/11 08:56:10 lordvan Exp $

inherit twisted distutils eutils

MY_P=Mantissa-${PV}
DESCRIPTION="An extensible, multi-protocol, multi-user, interactive application server"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodMantissa"
SRC_URI="http://divmod.org/trac/attachment/wiki/SoftwareReleases/${MY_P}.tar.gz?format=raw -> ${MY_P}.tar.gz"
#SRC_URI="mirror://gentoo/Mantissa-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
EAPI="2"

DEPEND=">=dev-lang/python-2.4
	>=dev-python/twisted-8.0.1
	dev-python/twisted-mail
	>=dev-python/nevow-0.9.5
	>=dev-python/axiom-0.5.7
	>=dev-python/vertex-0.2.0
	>=dev-python/pytz-2005m
	>=dev-python/imaging-1.1.6
	>=dev-python/cssutils-0.9.5.1"

S="${WORKDIR}/Mantissa-${PV}"

DOCS="NAME.txt NEWS.txt"

src_compile() {
	# skip this, or epsilon will install the temporary "build" dir
	true
}

src_test() {
	PYTHONPATH=. trial xmantissa || die "trial failed"
}

src_install() {
	export PORTAGE_PLUGINCACHE_NOOP=1
	distutils_install
	unset PORTAGE_PLUGINCACHE_NOOP
}

pkg_postrm() {
	twisted_pkg_postrm
}

pkg_postinst() {
	twisted_pkg_postinst
}
