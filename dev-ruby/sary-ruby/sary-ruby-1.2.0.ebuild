# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sary-ruby/sary-ruby-1.2.0.ebuild,v 1.1 2005/03/30 15:13:12 usata Exp $

inherit ruby

IUSE=""

DESCRIPTION="Ruby Binding of Sary"
HOMEPAGE="http://sary.sourceforge.net/
	http://taiyaki.org/prime/"
SRC_URI="http://sary.sourceforge.net/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~alpha ~ppc ~ppc64"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"
#S="${WORKDIR}/${PN}"

DEPEND=">=app-text/sary-1.2.0"

src_unpack() {
	unpack ${A}
	rm -rf ${S}/debian	# workaround for ruby19
}
