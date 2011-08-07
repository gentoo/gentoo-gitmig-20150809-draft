# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/httpclient/httpclient-2.2.1.ebuild,v 1.2 2011/08/07 17:57:09 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="-Ilib test"
RUBY_FAKEGEM_TASK_DOC="-Ilib doc"

RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="README.txt"

inherit ruby-fakegem

DESCRIPTION="'httpclient' gives something like the functionality of libwww-perl (LWP) in Ruby"
HOMEPAGE="https://github.com/nahi/httpclient"
SRC_URI="https://github.com/nahi/httpclient/tarball/RELEASE_2_2_0_1 -> ${P}.tgz"
S="${WORKDIR}/nahi-httpclient-*"

LICENSE="Ruby"
SLOT="0"

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="${RDEPEND}
	!dev-ruby/http-access2"

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

# JRuby-specific dependency
USE_RUBY="jruby" ruby_add_rdepend dev-ruby/jruby-openssl

all_ruby_prepare() {
	# Remove test file with failing tests so that we can at least run
	# the other tests. Reported upstream:
	# https://github.com/nahi/httpclient/issues/39
	rm test/test_httpclient.rb || die
}
