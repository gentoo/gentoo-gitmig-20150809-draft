# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/require_relative/require_relative-1.0.2.ebuild,v 1.5 2011/08/25 15:36:54 jer Exp $

EAPI=4
USE_RUBY="ruby18 ree18 jruby"

# Documentation can be generated using rocco but that is not available
# yet.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Backport require_relative from ruby 1.9.2."
HOMEPAGE="http://steveklabnik.github.com/require_relative"

LICENSE="|| ( Ruby BSD WTFPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile test/require_relative_test.rb || die
}
