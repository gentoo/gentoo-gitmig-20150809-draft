# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/multi_xml/multi_xml-0.5.1.ebuild,v 1.1 2012/05/17 15:37:43 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="doc:yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="A generic swappable back-end for XML parsing"
HOMEPAGE="http://rdoc.info/gems/multi_xml"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/yard )"
ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.5:2 )"

all_ruby_prepare() {
	rm Gemfile || die

	# Remove possible incompatible rspec options.
	rm .rspec || die
}

each_ruby_test() {
	CI=true ${RUBY} -S rspec spec || die
}
