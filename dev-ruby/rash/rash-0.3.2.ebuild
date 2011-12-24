# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rash/rash-0.3.2.ebuild,v 1.1 2011/12/24 13:26:05 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Rash is an extension to Hashie."
HOMEPAGE="https://github.com/tcocca/rash"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/hashie-1.2.0"
ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.5.0:2 )"

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die
}
