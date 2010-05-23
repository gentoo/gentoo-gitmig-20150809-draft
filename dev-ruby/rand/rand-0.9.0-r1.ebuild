# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rand/rand-0.9.0-r1.ebuild,v 1.1 2010/05/23 08:09:53 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="A Ruby library for picking random elements and shuffling."
HOMEPAGE="http://chneukirchen.org/blog/static/projects/rand.html"
SRC_URI="http://chneukirchen.org/releases/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

each_ruby_test() {
	${RUBY} rand.rb || die "Unable to run tests."
}

each_ruby_install() {
	doruby rand.rb
}

all_ruby_install() {
	dodoc ChangeLog README
	dohtml -r html
}
