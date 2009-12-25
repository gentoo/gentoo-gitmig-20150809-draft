# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gemcutter/gemcutter-0.2.1.ebuild,v 1.1 2009/12/25 14:20:01 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Add commands to gem for gemcutter.org operations"
HOMEPAGE="http://github.com/qrush/gemcutter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend dev-ruby/json

# gem file only distributes the tests' frontend, but not the actual
# frontend; upstream github repository is not tagged, so we cannot
# fetch a tarball.
RESTRICT=test

#ruby_add_bdepend test "dev-ruby/shoulda dev-ruby/fakeweb dev-ruby/rr"

each_ruby_test() {
	${RUBY} -Ilib test/*.rb || die "tests failed"
}
