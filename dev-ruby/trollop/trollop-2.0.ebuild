# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/trollop/trollop-2.0.ebuild,v 1.1 2012/09/23 16:39:03 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="FAQ.txt History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Trollop is a commandline option parser for Ruby."
HOMEPAGE="http://trollop.rubyforge.org/"
LICENSE="Ruby"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
SLOT="0"
IUSE=""

each_ruby_test() {
	${RUBY} -I lib test/test_trollop.rb || die "Tests failed."
}
