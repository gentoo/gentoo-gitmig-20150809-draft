# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/npm/npm-1.1.0_beta7.ebuild,v 1.1 2011/12/24 10:31:04 weaver Exp $

EAPI=4

EGIT_REPO_URI="https://github.com/isaacs/npm.git"
EGIT_COMMIT=v${PV/_beta/-beta-}
# git-2.eclass does not support recursive submodule update
#EGIT_HAS_SUBMODULES=yes

inherit eutils base git-2

DESCRIPTION="A package manager for node.js"
HOMEPAGE="http://npmjs.org/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=net-libs/nodejs-0.6.6"
RDEPEND="${DEPEND}"

MAKEOPTS=-j1

src_configure() {
	econf --prefix="${D}/usr"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS || die
	dodoc -r doc || die
}
