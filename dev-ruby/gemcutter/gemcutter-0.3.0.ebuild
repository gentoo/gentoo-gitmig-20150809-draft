# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gemcutter/gemcutter-0.3.0.ebuild,v 1.1 2010/01/05 17:52:13 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_VERSION="${PV/_pre/.pre}"

inherit ruby-fakegem

DESCRIPTION="Add commands to gem for gemcutter.org operations"
HOMEPAGE="http://github.com/qrush/gemcutter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend dev-ruby/json

ruby_add_bdepend test "dev-ruby/shoulda dev-ruby/webmock dev-ruby/rr dev-ruby/activesupport"
