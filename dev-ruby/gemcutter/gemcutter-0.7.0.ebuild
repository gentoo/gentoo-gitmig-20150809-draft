# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gemcutter/gemcutter-0.7.0.ebuild,v 1.1 2011/02/27 07:29:43 graaff Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Add commands to gem for gemcutter.org operations"
HOMEPAGE="http://github.com/rubygems/gemcutter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend dev-ruby/json

ruby_add_bdepend "
	test? (
		dev-ruby/shoulda
		>=dev-ruby/webmock-1.4.0
		dev-ruby/rr
		dev-ruby/activesupport
		virtual/ruby-test-unit
	)"
