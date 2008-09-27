# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/svnmailer/svnmailer-1.0.8-r2.ebuild,v 1.2 2008/09/27 13:49:44 betelgeuse Exp $

EAPI=2

inherit distutils eutils

DESCRIPTION="A subversion commit notifier written in Python"
SRC_URI="http://storage.perlig.de/svnmailer/${P}.tar.bz2"
HOMEPAGE="http://opensource.perlig.de/svnmailer/"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
LICENSE="Apache-2.0"

DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND}
	dev-util/subversion[python]
	virtual/mta"

DOCS="CHANGES NOTICE CREDITS"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-python2.5.diff"
}

src_install() {
	distutils_src_install

	dohtml -r docs/* || die "failed to install HTML documentation"
}
