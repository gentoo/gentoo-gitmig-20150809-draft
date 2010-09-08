# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/zentest/zentest-4.3.3.ebuild,v 1.3 2010/09/08 13:05:10 fauli Exp $

EAPI=2

USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_NAME=ZenTest

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt example.txt example1.rb example2.rb example_dot_autotest.rb"

inherit ruby-fakegem

DESCRIPTION="ZenTest provides tools to support testing: zentest, unit_diff, autotest, multiruby, and Test::Rails"
HOMEPAGE="http://rubyforge.org/projects/zentest/"
LICENSE="Ruby"

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-solaris"
SLOT="0"
IUSE=""

ruby_add_bdepend "
	doc? (
		>=dev-ruby/hoe-2.6.0
		dev-ruby/hoe-seattlerb
	)
	test? (
		>=dev-ruby/hoe-2.6.0
		dev-ruby/hoe-seattlerb
		virtual/ruby-minitest
	)"

each_ruby_test() {
	# JRuby needs the extended objectspace. We do it here
	# unconditional in this easy way.
	JRUBY_OPTS="${JRUBY_OPTS} -X+O" each_fakegem_test
}
