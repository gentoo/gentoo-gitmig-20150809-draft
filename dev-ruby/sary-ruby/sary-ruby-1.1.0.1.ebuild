# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sary-ruby/sary-ruby-1.1.0.1.ebuild,v 1.3 2005/02/12 08:07:52 usata Exp $

inherit ruby

IUSE=""

DESCRIPTION="Ruby Binding of Sary"
HOMEPAGE="http://sary.namazu.org/#ruby
	http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="x86 alpha ppc ~ppc64"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"
#S="${WORKDIR}/${PN}"

DEPEND=">=app-text/sary-1.1.0"

src_unpack() {
	unpack ${A}
	rm -rf ${S}/debian	# workaround for ruby19
}
