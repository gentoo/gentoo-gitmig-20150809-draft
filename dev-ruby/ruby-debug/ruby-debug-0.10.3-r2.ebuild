# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-debug/ruby-debug-0.10.3-r2.ebuild,v 1.3 2010/01/16 16:00:59 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

# The Rakefile has targets that are part of ruby-debug-base, so avoid
# hitting it for now.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_EXTRADOC="AUTHORS ChangeLog CHANGES README"

RUBY_FAKEGEM_EXTRAINSTALL="cli"
RUBY_FAKEGEM_REQUIRE_PATHS="cli"

inherit ruby-fakegem

DESCRIPTION="CLI interface to ruby-debug"
HOMEPAGE="http://rubyforge.org/projects/ruby-debug/"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""
SLOT="0"

ruby_add_rdepend "~dev-ruby/ruby-debug-base-0.10.3 >=dev-ruby/columnize-0.1"

each_ruby_compile() {
	# No compilation needed but Rakefile has targets anyway.
	local noop=true;
}

all_ruby_compile() {
	# No compilation needed but Rakefile has targets anyway.
	local noop=true;
}
