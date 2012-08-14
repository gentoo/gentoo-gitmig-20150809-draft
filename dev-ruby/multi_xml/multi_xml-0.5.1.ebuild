# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/multi_xml/multi_xml-0.5.1.ebuild,v 1.2 2012/08/14 04:32:48 flameeyes Exp $

EAPI=4

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_TASK_DOC="doc:yard"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A generic swappable back-end for XML parsing"
HOMEPAGE="http://rdoc.info/gems/multi_xml"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/yard )"

all_ruby_prepare() {
	# Remove possible incompatible rspec options and bundler.
	rm Gemfile .rspec || die
}

each_ruby_test() {
	CI=true each_fakegem_test
}
