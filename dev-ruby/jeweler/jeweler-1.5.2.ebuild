# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jeweler/jeweler-1.5.2.ebuild,v 1.1 2011/03/11 13:15:19 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"

# Tests and features also need the same set of dependencies present.
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="ChangeLog.markdown README.markdown"

inherit ruby-fakegem

DESCRIPTION="Rake tasks for managing gems and versioning and a generator for creating a new project"
HOMEPAGE="http://wiki.github.com/technicalpickles/jeweler"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/yard )"

# We do not depend on runtime dependencies since the usage of jeweler in
# Rakefile's does not require this. However, the generator does, but it
# depends on gems that are obsolete and not supported in Gentoo.

all_ruby_prepare() {
	# Remove bundler support.
	rm Gemfile Gemfile.lock || die
	sed -i -e '/bundler/d' -e '/Bundler.setup/d' Rakefile test/test_helper.rb features/support/env.rb || die
}
