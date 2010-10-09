# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rest-client/rest-client-1.6.1.ebuild,v 1.2 2010/10/09 07:59:44 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_EXTRADOC="history.md README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Simple Simple HTTP and REST client for Ruby"
HOMEPAGE="http://github.com/archiloque/rest-client"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/jeweler )"
ruby_add_bdepend "test? ( dev-ruby/jeweler dev-ruby/rspec:0 dev-ruby/webmock )"

ruby_add_rdepend ">=dev-ruby/mime-types-1.16"
