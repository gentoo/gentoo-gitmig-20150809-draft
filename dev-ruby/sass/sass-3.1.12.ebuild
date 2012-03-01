# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sass/sass-3.1.12.ebuild,v 1.2 2012/03/01 20:53:43 grobian Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_EXTRAINSTALL="rails init.rb VERSION VERSION_NAME"

inherit ruby-fakegem

DESCRIPTION="An extension of CSS3, adding nested rules, variables, mixins, selector inheritance, and more."
HOMEPAGE="http://sass-lang.com/"
LICENSE="MIT"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x64-macos"
SLOT="0"
IUSE=""

ruby_add_bdepend "doc? ( >=dev-ruby/yard-0.5.3 >=dev-ruby/maruku-0.5.9 )"

ruby_add_rdepend "dev-ruby/fssm !!<dev-ruby/haml-3.1"

all_ruby_prepare() {
	# Avoid tests depending on ordering of hashes.
	sed -i -e '/test_mixin_include_with_keyword_args/,/ end/ s:^:#:' test/sass/conversion_test.rb || die
}
