# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysfml/pysfml-1.6.ebuild,v 1.1 2011/02/07 11:44:08 radhermit Exp $

EAPI=3
PYTHON_DEPEND="2:2.6 3"
PYTHON_MODNAME="PySFML"

inherit distutils

DESCRIPTION="Python library for the Simple and Fast Multimedia Library (SFML)"
HOMEPAGE="http://sfml.sourceforge.net/"
SRC_URI="mirror://sourceforge/sfml/SFML-${PV}-python-sdk.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="media-libs/libsfml"
RDEPEND="${DEPEND}"

S="${WORKDIR}/SFML-${PV}/python"

src_install() {
	distutils_src_install
	use doc && dohtml doc/*

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/* || die "doins failed"
	fi
}
