# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/aws-s3/aws-s3-0.6.2-r1.ebuild,v 1.5 2010/09/18 09:09:29 graaff Exp $

EAPI=2

USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_TASK_DOC="doc:rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README"

RUBY_FAKEGEM_BINWRAP="s3sh"

inherit ruby-fakegem

DESCRIPTION="Client library for Amazon's Simple Storage Service's REST API"
HOMEPAGE="http://amazon.rubyforge.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/xml-simple
				dev-ruby/builder
				dev-ruby/mime-types"
ruby_add_bdepend test "virtual/ruby-test-unit dev-ruby/ruby-debug dev-ruby/flexmock"

all_ruby_prepare() {
	# As of release 0.6.2 this part is going to break when building
	# with Ruby 1.9; we disable it since we don't need it at all.
	sed -i -e '/^namespace :site/,/^end/ d' "${S}"/Rakefile \
		|| die "sed out of rake's :site namespace failed"

	# The .erb file is not shipped, so avoid rebuilding it.
	sed -i -e "/:rdoc => 'doc:readme'/d" Rakefile || die
}
