# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amazon-ec2/amazon-ec2-0.9.17.ebuild,v 1.1 2011/07/21 10:00:37 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc ChangeLog"

RUBY_FAKEGEM_BINWRAP="ec2sh"

inherit ruby-fakegem

DESCRIPTION="Library for accessing the Amazon Web Services EC2 and related"
HOMEPAGE="http://github.com/grempe/amazon-ec2"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# We only need yard for Ruby 1.8, as we use it for documentation
# generation. It is however also loaded when we run tests.
USE_RUBY=ruby18 \
	ruby_add_bdepend "doc? ( dev-ruby/yard )"

ruby_add_bdepend "
	test? (
		virtual/ruby-test-unit
		>=dev-ruby/test-spec-0.10.0
		>=dev-ruby/mocha-0.9.8
		dev-ruby/yard
	)"
ruby_add_rdepend '>=dev-ruby/xml-simple-1.0.12'

each_ruby_prepare() {
	case ${RUBY} in
		*ruby19)
			;;
		*)
			# Remove the reference to test-unit gem, since it's only
			# available on Ruby 1.9.
			sed -i -e '/^gem/s:^:#:' test/test_helper.rb || die
			;;
	esac

	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die
}
