# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-bsearch/ruby-bsearch-1.5-r2.ebuild,v 1.6 2010/09/28 23:51:35 ranger Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="A binary search library for Ruby"
HOMEPAGE="http://0xcc.net/ruby-bsearch/"
SRC_URI="http://0xcc.net/ruby-bsearch/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DOCS="ChangeLog *.rd bsearch.png"

all_ruby_prepare() {
	sed -i 's/ruby/\$\{RUBY\}/' tests/test.sh || die "Unable to fix tests shell script."
}

each_ruby_test() {
	pushd tests
	RUBY=${RUBY} sh test.sh
	popd
}

each_ruby_install() {
	doruby bsearch.rb
}

all_ruby_install() {
	dodoc ${DOCS}
}
