# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/samuel/samuel-0.3.1.ebuild,v 1.1 2010/01/12 13:58:07 flameeyes Exp $

EAPI=2

# jruby → tests need fakeweb
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="An automatic logger for HTTP requests in Ruby."
HOMEPAGE="http://github.com/chrisk/samuel"

LICENSE="as-is" # truly
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_prepare() {
	# check_dependencies only is available with jeweler
	# proper fix sent upstream after release 0.3.1
	sed -i -e '/=> :check_dependencies/s:^:#:' \
		Rakefile || die "fix rakefile failed"

	# sent upstream after release 0.3.1
	epatch "${FILESDIR}"/${P}-ruby19.patch
}

ruby_add_bdepend test "dev-ruby/shoulda dev-ruby/fakeweb"
