# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mongoid/mongoid-2.4.1.ebuild,v 1.3 2012/01/19 22:08:15 flameeyes Exp $

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

DESCRIPTION="ODM (Object Document Mapper) Framework for MongoDB"
HOMEPAGE="http://mongoid.org/"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_PROJECT}/tarball/v${PV} -> ${GITHUB_PROJECT}-${PV}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# there is support to create a custom mongodb instance now but there are
# still issues to be fixed.
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

DEPEND+=" test? ( dev-db/mongodb )"

all_ruby_prepare() {
	# remove references to bundler, as the gemfile does not add anything
	# we need to care about.
	sed -i -e '/[bB]undler/d' Rakefile || die
	# remove the Gemfile as well or it'll try to load it during testing
	rm Gemfile || die

	# the specsuite requires to connect to a mongodb instance; since we
	# _really_ don't want to connect to the system-configured mongodb
	# instance we replace the localhost address with another loopback
	# address (127.0.0.0/8 is all local), which we'll use later.
	find spec -type f -exec \
		sed -i \
		-e 's:localhost:127.255.255.254:g' \
		-e '/Mongo::Connection/s:\.new\.:.new("127.255.255.254").:g' \
		{} + || die

	# and fix a few references that should have been from `localhost`
	sed -i -e '139,$ s:127\.255\.255\.254:localhost:g' \
		spec/functional/mongoid/config/database_spec.rb || die
}

each_ruby_test() {
	mkdir "${T}/mongodb_$(basename $RUBY)"
	mongod --port 27017 --dbpath "${T}/mongodb_$(basename $RUBY)" \
		--noprealloc --noauth --nohttpinterface --nounixsocket --nojournal \
		--bind_ip 127.255.255.254 &
	mongod_pid=$!

	sleep 2

	${RUBY} -S rake spec || failed=1
	kill "${mongod_pid}"

	[ -n ${failed} ] && die "tests failed"
}
