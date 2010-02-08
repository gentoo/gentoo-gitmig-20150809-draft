# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/plist/plist-3.0.0-r1.ebuild,v 1.1 2010/02/08 20:08:16 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="A library to manipulate Property List files, also known as plists"
HOMEPAGE="http://plist.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

# There are test failures. Reported upstream as
# http://rubyforge.org/tracker/index.php?func=detail&aid=27797&group_id=2006&atid=7829
RESTRICT="test"

all_ruby_prepare() {
	# The Rakefile task for documentations depends on this being present.
	touch CHANGELOG

	# And it uses a template that is not available
	sed -i 's/docs\/jamis-template.rb/html/' Rakefile || die "Unable to change template"
}
