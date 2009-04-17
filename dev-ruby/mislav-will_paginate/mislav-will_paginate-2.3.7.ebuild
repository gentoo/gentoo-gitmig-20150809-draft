# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mislav-will_paginate/mislav-will_paginate-2.3.7.ebuild,v 1.1 2009/04/17 12:37:41 flameeyes Exp $

EAPI=2

inherit ruby

DESCRIPTION="Most awesome pagination solution for Ruby  "
HOMEPAGE="http://github.com/mislav/will_paginate/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples"

SRC_URI="http://github.com/mislav/will_paginate/tarball/v${PV} -> ${P}.tgz"

USE_RUBY="ruby18"

DEPEND="doc? ( dev-ruby/rake )
	test? ( dev-ruby/rake )"
RDEPEND=">=dev-ruby/activesupport-1.4.4"

S="${WORKDIR}"

src_prepare() {
	cd "${WORKDIR}"/${PN}-*

	sed -i -e "/s\.name/s:will_paginate:${PN}:" will_paginate.gemspec || die "unable to fix gemspec"
}

src_compile() {
	cd "${WORKDIR}"/${PN}-*

	if use doc; then
		rake rdoc || die "rake rdoc failed"
	fi
}

src_test() {
	cd "${WORKDIR}"/${PN}-*

	rake test || die "rake test failed"
}

src_install() {
	cd "${WORKDIR}"/${PN}-*

	pushd lib
	doruby -r * || die "install lib failed"
	popd

	insinto $(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')/../gems/1.8/specifications
	newins will_paginate.gemspec ${P}.gemspec || die "Unable to install fake gemspec"

	dodoc CHANGELOG.rdoc README.rdoc || die "Installing docs failed."

	if use doc; then
		pushd doc
		dohtml -r * || die "Installing html documentation failed."
		popd
	fi

	if use examples; then
		docinto examples
		dodoc examples/* || die "Installing examples failes."
	fi
}
