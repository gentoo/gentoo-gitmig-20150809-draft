# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/flexmock/flexmock-0.8.11.ebuild,v 1.1 2010/10/20 17:54:12 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_DOCDIR="html"
RUBY_FAKEGEM_EXTRADOC="CHANGES README.rdoc doc/*.rdoc doc/releases/*"

inherit ruby-fakegem

DESCRIPTION="Simple mock object library for Ruby unit testing"
HOMEPAGE="http://${PN}.rubyforge.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

all_ruby_prepare() {
	# Custom template not found in package
	sed -i -e '/jamis/d' Rakefile || die
}
