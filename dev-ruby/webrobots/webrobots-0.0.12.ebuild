# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/webrobots/webrobots-0.0.12.ebuild,v 1.1 2011/10/31 06:58:58 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A library to help write robots.txt compliant web robots."
HOMEPAGE="http://rubygems.org/gems/webrobots"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/nokogiri-1.4.4"

ruby_add_bdepend "test? ( dev-ruby/shoulda )"

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/bundler/,/end/d' Rakefile test/helper.rb || die
	sed -i -e '/rcovtask/,/end/d' \
		   -e '/jeweler/,/RubygemsDotOrgTasks/d' Rakefile || die
}
