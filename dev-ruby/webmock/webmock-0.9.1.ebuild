# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/webmock/webmock-0.9.1.ebuild,v 1.2 2010/07/20 07:35:47 fauli Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="test spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="Allows stubbing HTTP requests and setting expectations on HTTP requests"
HOMEPAGE="http://github.com/bblimke/webmock"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend dev-ruby/addressable

ruby_add_bdepend test 'virtual/ruby-test-unit >=dev-ruby/rspec-1.2.9 >=dev-ruby/httpclient-2.1.5.2'

all_ruby_prepare() {
	# Don't require check_dependencies (using Jeweler)
	sed -i \
		-e '/=> :check_dependencies/s:^:#:' \
		Rakefile || die "Rakefile fix failed"
}
