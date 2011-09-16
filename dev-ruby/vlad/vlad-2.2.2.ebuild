# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/vlad/vlad-2.2.2.ebuild,v 1.1 2011/09/16 19:23:38 graaff Exp $

EAPI=4
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="considerations.txt History.txt README.txt"

RUBY_FAKEGEM_GEMSPEC="vlad.gemspec"

inherit ruby-fakegem

DESCRIPTION="Pragmatic application deployment automation, without mercy."
HOMEPAGE="http://rubyhitsquad.com/Vlad_the_Deployer.html"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend ">=dev-ruby/hoe-2.9.2 test? ( dev-ruby/minitest )"
ruby_add_rdepend ">=dev-ruby/open4-0.9.0 >=dev-ruby/rake-remote_task-2.0.0"

all_ruby_prepare() {
	# Be more lenient in open4 versions since we have not slotted it.
	sed -i -e 's/~> 0.9.0/>= 0.9.0/' Rakefile || die
	rake debug_gem | sed 1d > vlad.gemspec || die
}
