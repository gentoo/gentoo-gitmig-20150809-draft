# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eyeD3/eyeD3-0.6.14.ebuild,v 1.5 2007/08/13 20:37:46 dertobi123 Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Module for manipulating ID3 (v1 + v2) tags in Python"
HOMEPAGE="http://eyed3.nicfit.net/"
SRC_URI="http://eyed3.nicfit.net/releases/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ia64 ppc ppc64 ~sparc x86"

src_compile() {
	econf || die "econf failed"
	distutils_src_compile
}

src_install() {
	# Not calling make install because
	# we would have to patch it (for example bug #164310)
	# and it's therefore easier to do it manually

	DOCS="AUTHORS NEWS THANKS"
	dohtml README.html && rm README.html

	distutils_src_install

	dobin bin/eyeD3
	doman doc/eyeD3.1
}
