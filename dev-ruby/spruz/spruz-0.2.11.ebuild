# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/spruz/spruz-0.2.11.ebuild,v 1.3 2011/07/24 18:12:36 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="All the stuff that isn't good enough for a real library."
HOMEPAGE="http://github.com/flori/spruz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit ) "

all_ruby_prepare() {
	# sdoc is not available for Gentoo yet, use rdoc instead
	sed -i -e 's/sdoc/rdoc/' Rakefile || die
	# Fix glob expansion so that documentation can be built
	sed -i -e "s/} \* ' '}/.join(' ')}/" Rakefile || die
}

each_ruby_test() {
	${RUBY} -Ilib -S testrb tests/* || die
}
