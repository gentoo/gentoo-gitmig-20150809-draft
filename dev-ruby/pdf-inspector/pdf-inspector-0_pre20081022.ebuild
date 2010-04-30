# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pdf-inspector/pdf-inspector-0_pre20081022.ebuild,v 1.2 2010/04/30 20:19:37 graaff Exp $

EAPI=2

GITHUB_USER=sandal
GITHUB_TREE=021fbbf4cd121673bdf5310834eac038cc6aa080

inherit ruby

DESCRIPTION="A collection of PDF::Reader based analysis classes for inspecting PDF output"
HOMEPAGE="http://github.com/${GITHUB_USER}/${PN}/tree/master"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/${GITHUB_TREE} -> ${P}.tgz"
SRC_URI="mirror://gentoo/${P}.tgz"

USE_RUBY="ruby18"

DEPEND=""
RDEPEND="dev-ruby/pdf-reader"

S="${WORKDIR}"

src_install() {
	cd "${WORKDIR}"/${GITHUB_USER}-${PN}-*

	pushd lib
	doruby -r * || die "install lib failed"
	popd

	dodoc README || die
}
