# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-prof/ruby-prof-0.7.0.ebuild,v 1.1 2008/11/13 04:00:46 flameeyes Exp $

inherit ruby

DESCRIPTION="A module for profiling Ruby code"
HOMEPAGE="http://rubyforge.org/projects/ruby-prof/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="virtual/ruby"
DEPEND="${RDEPEND}
	test? ( dev-ruby/rake )
	doc? ( dev-ruby/rake )"

USE_RUBY="ruby18"

# Tests don't work on 0.7.0 version, but I contacted upstream to get
# them fixed.
RESTRICT="test"

src_compile() {
	cd "${S}/ext"
	ruby_econf || die "ruby_econf failed"
	ruby_emake || die "ruby_emake failed"

	if use doc; then
		rake rdoc || die "rake rdoc failed"
	fi
}

src_test() {
	rake test || die "rake test failed"
}

src_install() {
	dobin bin/ruby-prof || die "dobin failed"

	cd "${S}"/lib
	doruby -r * || die "doruby failed"

	cd "${S}"/ext
	ruby_einstall || die "ruby_einstall failed"

	cd "${S}"

	dodoc README CHANGES || die "dodoc failed"

	if use doc; then
		dohtml -r doc/* || die "dohtml failed"
	fi


	for dir in examples rails rails/example rails/environment; do
		docinto $dir
		dodoc $dir/* || die "dodoc $dir failed"
	done
}
