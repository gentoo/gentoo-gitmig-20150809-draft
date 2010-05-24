# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/daemons/daemons-1.0.10-r1.ebuild,v 1.4 2010/05/24 21:51:55 a3li Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_EXTRADOC="Releases README TODO"
RUBY_FAKEGEM_DOCDIR="html"

# There are no tests :( the gem is shipped with some tests but so
# commented they make no sense, so we cannot run them, too bad.
RAKE_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Wrap existing ruby scripts to be run as a daemon"
HOMEPAGE="http://daemons.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="|| ( Ruby GPL-2 ) MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="examples"

all_ruby_prepare() {
	sed -i -e '/manage_gems/s:^:#:' Rakefile || die "Fixing Rakefile failed"
}

all_ruby_install() {
	all_fakegem_install

	use examples || return

	insinto /usr/share/doc/${PF}/
	doins -r examples || die "Failed to install examples"
}
