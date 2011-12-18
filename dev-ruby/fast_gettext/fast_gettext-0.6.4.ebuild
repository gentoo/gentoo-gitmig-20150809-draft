# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fast_gettext/fast_gettext-0.6.4.ebuild,v 1.1 2011/12/18 08:58:57 graaff Exp $

EAPI="4"

# jruby support requires sqlite3 support for jruby.
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG Readme.md"

RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_EXTRAINSTALL="VERSION"

inherit ruby-fakegem

DESCRIPTION="GetText but 3.5 x faster, 560 x less memory, simple, clean namespace (7 vs 34) and threadsave!"
HOMEPAGE="https://github.com/grosser/fast_gettext"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/activerecord dev-ruby/bundler )"

all_ruby_prepare() {
	rm Gemfile.lock || die

	# Don't run a test that requires safe mode which we can't provide
	# due to insecure directory settings for the portage dir. This spec
	# also calls out to ruby which won't work with different ruby
	# implementations.
	sed -i -e '/can work in SAFE mode/,/end/ s:^:#:' spec/fast_gettext/translation_repository/mo_spec.rb || die
}

each_ruby_test() {
	${RUBY} -S rspec spec || die
}
