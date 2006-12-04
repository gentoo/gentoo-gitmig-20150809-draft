# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sary-ruby/sary-ruby-1.2.0.ebuild,v 1.11 2006/12/04 04:07:33 weeve Exp $

inherit ruby flag-o-matic

IUSE=""

DESCRIPTION="Ruby Binding of Sary"
HOMEPAGE="http://sary.sourceforge.net/
	http://taiyaki.org/prime/"
SRC_URI="http://sary.sourceforge.net/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 sparc x86"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"
#S="${WORKDIR}/${PN}"

DEPEND=">=app-text/sary-1.2.0"

src_unpack() {
	unpack ${A}
	rm -rf ${S}/debian	# workaround for ruby19
}

src_compile() {
	append-flags   `pkg-config sary --cflags`
	append-ldflags `pkg-config sary --libs`
	ruby_src_compile || die
}
