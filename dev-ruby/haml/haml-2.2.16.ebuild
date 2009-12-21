# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/haml/haml-2.2.16.ebuild,v 1.2 2009/12/21 14:47:18 flameeyes Exp $

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
KEYWORDS="~amd64"

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

# It could use merb during testing as well, but it's not mandatory
ruby_add_bdepend test "virtual/ruby-test-unit dev-ruby/rack"
ruby_add_bdepend doc "dev-ruby/yard dev-ruby/maruku"
