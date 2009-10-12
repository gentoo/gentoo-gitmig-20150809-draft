# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/svnmailer/svnmailer-1.0.8-r2.ebuild,v 1.3 2009/10/12 08:16:40 ssuominen Exp $

EAPI=2
inherit distutils eutils

DESCRIPTION="A subversion commit notifier written in Python"
SRC_URI="http://storage.perlig.de/svnmailer/${P}.tar.bz2"
HOMEPAGE="http://opensource.perlig.de/svnmailer/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND}
	dev-util/subversion[python]
	virtual/mta"

DOCS="CHANGES NOTICE CREDITS"

src_prepare() {
	epatch "${FILESDIR}"/${P}-python2.5.diff
}

src_install() {
	distutils_src_install
	dohtml -r docs/* || die "failed to install HTML documentation"
}
