# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/uglifier/uglifier-1.2.2.ebuild,v 1.3 2012/03/05 10:03:18 tomka Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18"

# Avoid building documentation to avoid dependencies on bundler and jeweler
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Ruby wrapper for UglifyJS JavaScript compressor."
HOMEPAGE="https://github.com/lautis/uglifier"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"

IUSE="test"

# Tests requires additional uglifyjs test code in a vendored git submodule.
RESTRICT="test"

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

ruby_add_rdepend ">=dev-ruby/execjs-0.3.0 >=dev-ruby/multi_json-1.0.2"

each_ruby_test() {
	${RUBY} -S rspec spec || die
}
