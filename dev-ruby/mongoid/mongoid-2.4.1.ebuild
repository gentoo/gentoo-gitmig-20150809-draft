# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mongoid/mongoid-2.4.1.ebuild,v 1.1 2012/01/16 20:54:15 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18"

#RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec:unit"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

GITHUB_USER="${PN}"
GITHUB_PROJECT="${PN}"
RUBY_S="${GITHUB_USER}-${GITHUB_PROJECT}-*"

inherit ruby-fakegem

DESCRIPTION="http://mongoid.org/"
HOMEPAGE="ODM (Object Document Mapper) Framework for MongoDB"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_PROJECT}/tarball/v${PV} -> ${GITHUB_PROJECT}-${PV}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# Testing requires a running system mongodb instance — and that's bad;
# instead restrict them for now; we'll get to it.
RESTRICT="test"

ruby_add_rdepend "
	>=dev-ruby/activemodel-3.1
	>=dev-ruby/mongo-1.3
	>=dev-ruby/tzinfo-0.3.22
"

ruby_add_bdepend "
	test? (
		dev-ruby/ammeter
		dev-ruby/mocha
		dev-ruby/rdoc
		dev-ruby/rspec
		dev-util/watchr
	)"

all_ruby_prepare() {
	# remove references to bundler, as the gemfile does not add anything
	# we need to care about.
	sed -i -e '/[bB]undler/d' Rakefile || die
	# remove the Gemfile as well or it'll try to load it during testing
	rm Gemfile || die
}
