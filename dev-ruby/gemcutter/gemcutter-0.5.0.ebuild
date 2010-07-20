# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gemcutter/gemcutter-0.5.0.ebuild,v 1.2 2010/07/20 07:37:01 fauli Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_VERSION="${PV/_pre/.pre}"

inherit ruby-fakegem

DESCRIPTION="Add commands to gem for gemcutter.org operations"
HOMEPAGE="http://github.com/rubygems/gemcutter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Tests don't work due to missing files. Upstream repository has
# already changed so much in this respect that is makes more sense to
# wait for the next release.
RESTRICT="test"

ruby_add_rdepend dev-ruby/json

ruby_add_bdepend test "dev-ruby/shoulda dev-ruby/webmock dev-ruby/rr dev-ruby/activesupport"
