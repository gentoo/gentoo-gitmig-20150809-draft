# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gemcutter/gemcutter-0.6.1.ebuild,v 1.1 2010/07/20 08:57:58 graaff Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Add commands to gem for gemcutter.org operations"
HOMEPAGE="http://github.com/rubygems/gemcutter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend dev-ruby/json

ruby_add_bdepend test "dev-ruby/shoulda dev-ruby/webmock dev-ruby/rr dev-ruby/activesupport"
