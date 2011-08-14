# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fssm/fssm-0.2.7-r1.ebuild,v 1.1 2011/08/14 07:23:25 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

inherit ruby-fakegem

DESCRIPTION="Monitor API"
HOMEPAGE="http://github.com/ttilley/fssm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# rb-inotify is a Linux-specific extension, so we will need to make this
# conditional when keywords are added that are not linux-specific.
ruby_add_rdepend ">=dev-ruby/rb-inotify-0.8.6-r1"

ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.4.0:2 )"

all_ruby_prepare() {
	# Remove bundler support
	sed -i -e '/[Bb]undler/d' Rakefile spec/spec_helper.rb || die
	rm Gemfile || die

	# Fix/ignore broken specs with patch from upstream
	epatch "${FILESDIR}/${P}-test.patch"
}

all_ruby_install() {
	all_fakegem_install

	dodoc example.rb
}
