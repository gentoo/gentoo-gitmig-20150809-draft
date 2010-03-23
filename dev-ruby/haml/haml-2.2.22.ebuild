# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/haml/haml-2.2.22.ebuild,v 1.1 2010/03/23 07:07:25 graaff Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="doc"

RUBY_FAKEGEM_EXTRADOC="CONTRIBUTING README.md"
RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem

DESCRIPTION="HAML - a ruby web page templating engine"
HOMEPAGE="http://haml.hamptoncatlin.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

# TODO: haml has some emacs modes that it could be installing, in case
IUSE=""

all_ruby_prepare() {
	sed -i -e '/haml.gemspec/,/Task\[:package\]/s:^:#:' "${S}"/Rakefile
}

each_ruby_install() {
	each_fakegem_install

	# This is needed otherwise it fails at runtime
	ruby_fakegem_doins VERSION VERSION_NAME
}

# The html engine requires hpricot
ruby_add_rdepend dev-ruby/hpricot

# It could use merb during testing as well, but it's not mandatory
ruby_add_bdepend test "virtual/ruby-test-unit dev-ruby/actionpack"
ruby_add_bdepend doc "dev-ruby/yard dev-ruby/maruku"
