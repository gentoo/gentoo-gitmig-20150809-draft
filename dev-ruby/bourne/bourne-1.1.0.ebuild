# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bourne/bourne-1.1.0.ebuild,v 1.1 2012/02/28 11:04:24 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_TASK_TEST="default"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Extends mocha to allow detailed tracking and querying of stub and mock invocations."
HOMEPAGE="http://github.com/thoughtbot/bourne"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "=dev-ruby/mocha-0.10*"

all_ruby_prepare() {
	sed -i \
		-e '/git ls-files/d' \
		-e '/dependency.*mocha/s:= 0.10.4:~> 0.10.3:' \
		"${RUBY_FAKEGEM_GEMSPEC}" || die

	sed -i -e '/bundler/d' Rakefile || die
}
