# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/arel/arel-2.2.1-r1.ebuild,v 1.2 2011/12/29 16:07:32 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.markdown"

# Generating the gemspec from metadata causes a crash in jruby
RUBY_FAKEGEM_GEMSPEC="arel.gemspec"

inherit ruby-fakegem

DESCRIPTION="Arel is a Relational Algebra for Ruby."
HOMEPAGE="http://github.com/rails/arel"
LICENSE="MIT"
SLOT="2.1"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	doc? ( >=dev-ruby/hoe-2.10 )
	test? (
		>=dev-ruby/hoe-2.10
		virtual/ruby-minitest
	)"

all_ruby_prepare() {
	# Put the proper version number in the gemspec.
	sed -i -e 's/2.2.0.20110809140134/2.2.1/' arel.gemspec || die
}
