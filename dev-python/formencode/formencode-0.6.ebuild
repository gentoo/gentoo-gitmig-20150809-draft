# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/formencode/formencode-0.6.ebuild,v 1.2 2006/11/27 23:35:40 kloeri Exp $

# TODO: Add pudge support via "doc" flag
#       currently broken with 0.6 release

inherit distutils

MY_PN="FormEncode"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HTML form validation, generation, and conversion package"
HOMEPAGE="http://formencode.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.3"

PYTHON_MODNAME=$MY_PN
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A} || die "Failed to unpack ${A}"
	cd ${S} || die "Failed to cd to ${S}"
	#We don't want to use setuptools until eggs.eclass is solid
	rm -rf ez_setup
	epatch ${FILESDIR}/${P}-setup-gentoo.patch
}

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins -r examples
}
