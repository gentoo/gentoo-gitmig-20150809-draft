# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ttfunk/ttfunk-0_pre20090123.ebuild,v 1.3 2010/05/01 00:51:56 flameeyes Exp $

EAPI=2

GITHUB_USER=sandal
GITHUB_TREE=900032abee9272485e77f6b68e87c9ad6346f69b

inherit ruby

DESCRIPTION="Get Ya TrueType Funk On! (Font Metrics Parser for Prawn)"
HOMEPAGE="http://github.com/sandal/ttfunk/tree/master"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/${GITHUB_TREE} -> ${P}.tgz"

USE_RUBY="ruby18"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	cd "${WORKDIR}"/${GITHUB_USER}-${PN}-*

	pushd lib
	doruby -r * || die "install lib failed"
	popd

	docinto examples
	dodoc example.rb || die
}
