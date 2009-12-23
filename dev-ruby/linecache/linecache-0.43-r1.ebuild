# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/linecache/linecache-0.43-r1.ebuild,v 1.1 2009/12/23 07:25:03 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_EXTRADOC="AUTHORS ChangeLog NEWS README"

inherit ruby-fakegem

DESCRIPTION="Caches files as might be used in a debugger or a tool that works with sets of Ruby source files."
HOMEPAGE="http://rubyforge.org/projects/rocky-hacks/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_newins ext/trace_nums.so lib/trace_nums.so
}

all_ruby_install() {
	all_fakegem_install

	if use doc; then
		dohtml -r doc || die
	fi
}
