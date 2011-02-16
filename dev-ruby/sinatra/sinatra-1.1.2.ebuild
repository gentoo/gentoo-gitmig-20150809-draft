# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sinatra/sinatra-1.1.2.ebuild,v 1.1 2011/02/16 07:15:59 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

# no documentation is generable, it needs hanna, which is broken
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.rdoc AUTHORS CHANGES"

inherit ruby-fakegem

DESCRIPTION="Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort."
HOMEPAGE="http://www.sinatrarb.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend '=dev-ruby/rack-1.1* =dev-ruby/tilt-1*'
ruby_add_bdepend "test? ( dev-ruby/rack-test >=dev-ruby/haml-3.0 dev-ruby/erubis dev-ruby/builder )"

all_ruby_prepare() {
	# Remove tests for optional templating system which is not
	# available in Gentoo.
	rm test/less_test.rb test/coffee_test.rb || die

	# Fix tests with haml3.
#	epatch "${FILESDIR}/${P}-haml3-tests.patch"
}
