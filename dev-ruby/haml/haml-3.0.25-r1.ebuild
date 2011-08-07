# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/haml/haml-3.0.25-r1.ebuild,v 1.4 2011/08/07 14:23:12 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="doc"

RUBY_FAKEGEM_EXTRADOC="CONTRIBUTING README.md"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb VERSION VERSION_NAME vendor"

inherit ruby-fakegem

DESCRIPTION="HAML - a ruby web page templating engine"
HOMEPAGE="http://haml-lang.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"

# TODO: haml has some emacs modes that it could be installing, in case
IUSE=""

# The html engine requires hpricot
ruby_add_rdepend "dev-ruby/hpricot dev-ruby/fssm"

# It could use merb during testing as well, but it's not mandatory
ruby_add_bdepend "
	test? (
		virtual/ruby-test-unit
		dev-ruby/erubis
		dev-ruby/rails
		dev-ruby/ruby_parser
	)
	doc? (
		dev-ruby/yard
		dev-ruby/maruku
	)"
