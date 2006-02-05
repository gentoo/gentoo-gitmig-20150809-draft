# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setuptools/setuptools-0.6_alpha9.ebuild,v 1.1 2006/02/05 20:23:19 marienz Exp $

inherit distutils

MY_P=${P/_alpha/a}
DESCRIPTION="A collection of enhancements to the Python distutils including easy install"
HOMEPAGE="http://peak.telecommunity.com/DevCenter/setuptools"
SRC_URI="http://cheeseshop.python.org/packages/source/s/setuptools/${MY_P}.zip"
LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-lang/python-2.4.2
	app-arch/zip"

DOCS="EasyInstall.txt api_tests.txt pkg_resources.txt setuptools.txt"

src_install() {
	${python} setup.py install --root=${D} --no-compile \
		--single-version-externally-managed "$@" || die

	DDOCS="CHANGELOG COPYRIGHT KNOWN_BUGS MAINTAINERS PKG-INFO"
	DDOCS="${DDOCS} CONTRIBUTORS TODO"
	DDOCS="${DDOCS} Change* MANIFEST* README*"

	for doc in ${DDOCS}; do
		[ -s "$doc" ] && dodoc $doc
	done

	[ -n "${DOCS}" ] && dodoc ${DOCS}

}
