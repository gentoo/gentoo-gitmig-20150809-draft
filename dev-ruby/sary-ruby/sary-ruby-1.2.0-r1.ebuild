# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sary-ruby/sary-ruby-1.2.0-r1.ebuild,v 1.1 2008/09/25 13:30:04 matsuu Exp $

inherit eutils ruby

IUSE=""

DESCRIPTION="Ruby Binding of Sary"
HOMEPAGE="http://sary.sourceforge.net/"
SRC_URI="http://sary.sourceforge.net/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"

RDEPEND=">=app-text/sary-1.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	rm -rf debian	# workaround for ruby19
}
