# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/childprocess/childprocess-0.1.8.ebuild,v 1.1 2011/04/09 07:43:10 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_GEMSPEC="childprocess.gemspec"

inherit ruby-fakegem

DESCRIPTION="A simple and reliable solution for controlling external programs running in the background."
HOMEPAGE="https://github.com/jarib/childprocess"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
	doc? ( dev-ruby/yard )
	test? ( dev-ruby/rspec:2 )"

ruby_add_rdepend "virtual/ruby-ffi"

all_ruby_prepare() {
	# Avoid hard dependency on jeweler.
	sed -i -e '/check_dependencies/d' Rakefile || die

	# Depend on any version of ffi, since 1.0.6 is not compatible with
	# ruby18 and ree18.
	sed -i -e 's/~> 1.0.6/>= 0/' childprocess.gemspec || die

	# Remove bundler support
	rm Gemfile || die
}
