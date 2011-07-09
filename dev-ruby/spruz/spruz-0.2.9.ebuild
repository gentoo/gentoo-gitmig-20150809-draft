# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/spruz/spruz-0.2.9.ebuild,v 1.1 2011/07/09 07:10:25 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem

DESCRIPTION="All the stuff that isn't good enough for a real library."
HOMEPAGE="http://github.com/flori/spruz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit ) "

all_ruby_prepare() {
	# sdoc is not available for Gentoo yet, use rdoc instead
	sed -i -e 's/sdoc/rdoc/' Rakefile || die
	# Fix glob expansion so that documentation can be built
	sed -i -e "s/} \* ' '}/.join(' ')}/" Rakefile || die
}
