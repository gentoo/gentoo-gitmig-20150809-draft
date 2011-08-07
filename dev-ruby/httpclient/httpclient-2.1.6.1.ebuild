# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/httpclient/httpclient-2.1.6.1.ebuild,v 1.2 2011/08/07 17:57:09 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="-Ilib test"
RUBY_FAKEGEM_TASK_DOC="-Ilib doc"

RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="README.txt"

inherit ruby-fakegem

DESCRIPTION="'httpclient' gives something like the functionality of libwww-perl (LWP) in Ruby"
HOMEPAGE="http://dev.ctor.org/http-access2/"
SRC_URI="http://dev.ctor.org/download/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="${RDEPEND}
	!dev-ruby/http-access2"

# tests are known to fail, but at least they fail for all
# implementations in the same way. Bug 335451.
RESTRICT="test"
ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

# JRuby-specific dependency
USE_RUBY="jruby" ruby_add_rdepend dev-ruby/jruby-openssl
