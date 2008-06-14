# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sary-ruby/sary-ruby-1.2.0.ebuild,v 1.14 2008/06/14 21:07:53 graaff Exp $

inherit ruby

IUSE=""

DESCRIPTION="Ruby Binding of Sary"
HOMEPAGE="http://sary.sourceforge.net/
	http://taiyaki.org/prime/"
SRC_URI="http://sary.sourceforge.net/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"

DEPEND=">=app-text/sary-1.2.0"

src_unpack() {
	unpack ${A}
	rm -rf "${S}"/debian	# workaround for ruby19
}

src_compile() {
	ruby_src_compile || die
}
