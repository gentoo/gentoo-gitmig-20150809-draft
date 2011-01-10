# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/webrat/webrat-0.7.1.ebuild,v 1.3 2011/01/10 18:31:05 graaff Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_TASK_TEST="spec:integration:rack spec:integration:sinatra spec:integration:mechanize"

RUBY_FAKEGEM_EXTRADOC="README.rdoc History.txt"

RUBY_FAKEGEM_EXTRAINSTALL="vendor"

inherit ruby-fakegem

DESCRIPTION="Ruby acceptance testing for web applications"
HOMEPAGE="http://github.com/brynary/webrat/"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86 ~x86-macos"
SLOT="0"
IUSE=""

ruby_add_rdepend ">=dev-ruby/nokogiri-1.2.0
	>=dev-ruby/rack-1.0"

ruby_add_bdepend test "dev-ruby/rspec:0 dev-ruby/rack-test dev-ruby/sinatra dev-ruby/mechanize"
