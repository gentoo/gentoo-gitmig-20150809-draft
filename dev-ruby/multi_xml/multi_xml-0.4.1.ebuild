# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/multi_xml/multi_xml-0.4.1.ebuild,v 1.2 2011/12/28 12:02:08 graaff Exp $

EAPI=4

# jruby is no longer supported by upstream starting with 0.3.0
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
	sed -i -e '/[Bb]undler/d' Rakefile spec/helper.rb || die
	sed -i -e '/[Ss]imple[Cc]ov/d' spec/helper.rb || die

	epatch "${FILESDIR}/${P}-ruby19.patch"
}
