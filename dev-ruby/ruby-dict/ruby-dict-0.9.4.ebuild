# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-dict/ruby-dict-0.9.4.ebuild,v 1.6 2009/01/18 10:30:59 flameeyes Exp $

inherit ruby

DESCRIPTION="RFC 2229 client in Ruby"
HOMEPAGE="http://www.caliban.org/ruby/ruby-dict.shtml"
SRC_URI="http://www.caliban.org/files/ruby/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

USE_RUBY="ruby18"

src_compile() { :; }

src_install() {
	doruby lib/dict.rb || die "doruby failed"

	dobin rdict || die "rdict failed"

	dodoc README Changelog TODO doc/rfc2229.txt
	dohtml doc/dict.html doc/rdict.html

	# This would probably need a 3rb section..
	# doman doc/dict.3
	doman doc/rdict.1 || die "doman failed"
}
