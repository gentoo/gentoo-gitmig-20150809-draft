# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-debug/ruby-debug-0.10.3-r3.ebuild,v 1.5 2010/07/17 17:23:09 armin76 Exp $

EAPI="2"
USE_RUBY="ruby18 jruby"

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
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""
SLOT="0"

ruby_add_rdepend ">=dev-ruby/columnize-0.1"

# The original extension is used for MRI (ruby18)
USE_RUBY="ruby18" \
	ruby_add_rdepend ruby_targets_ruby18 =dev-ruby/ruby-debug-base-0.10.3*

# An alternative extension is used for JRuby
USE_RUBY="jruby" \
	ruby_add_rdepend ruby_targets_jruby =dev-ruby/jruby-debug-base-0.10.3*
