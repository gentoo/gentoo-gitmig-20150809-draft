# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mime-types/mime-types-1.16-r2.ebuild,v 1.8 2011/01/07 11:08:27 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Install.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Provides a mailcap-like MIME Content-Type lookup for Ruby."
HOMEPAGE="http://rubyforge.org/projects/mime-types"

LICENSE="Ruby Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-macos"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/hoe )
	test? ( dev-ruby/hoe virtual/ruby-test-unit )"

all_ruby_prepare() {
	# when rcov is installed, and a new enough Hoe is installed as
	# well, the Rakefile will fail because Hoe::test_files is no
	# longer defined. Since we don't use rcov for testing, we just
	# disable the whole section unconditionally.
	sed -i -e '/rcovtask/,/end/ s:^:#:' Rakefile || die "Rakefile fix failed"
}
