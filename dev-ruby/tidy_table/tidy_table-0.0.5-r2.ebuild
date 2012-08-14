# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tidy_table/tidy_table-0.0.5-r2.ebuild,v 1.2 2012/08/14 00:07:02 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Tool to convert an array of struct into an HTML table."
HOMEPAGE="http://seattlerb.rubyforge.org/${PN}/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/hoe )"

all_ruby_prepare() {
	# Remove reference to RSpec 1
	sed -i -e '/spec/d' spec/spec_helper.rb || die
}
