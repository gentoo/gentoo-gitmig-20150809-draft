# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sass/sass-3.1.1.ebuild,v 1.4 2011/05/23 12:49:32 graaff Exp $

EAPI=2

# jruby fails tests: https://github.com/nex3/sass/issues/73
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_EXTRAINSTALL="rails init.rb VERSION VERSION_NAME"

inherit ruby-fakegem

DESCRIPTION="An extension of CSS3, adding nested rules, variables, mixins, selector inheritance, and more."
HOMEPAGE="http://sass-lang.com/"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ruby_add_bdepend "doc? ( >=dev-ruby/yard-0.5.3 >=dev-ruby/maruku-0.5.9 )"
ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend "dev-ruby/fssm !!<dev-ruby/haml-3.1"
