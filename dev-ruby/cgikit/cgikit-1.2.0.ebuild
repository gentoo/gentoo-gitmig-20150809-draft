# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cgikit/cgikit-1.2.0.ebuild,v 1.2 2004/05/25 18:46:25 mr_bones_ Exp $

inherit ruby

DESCRIPTION="CGIKit is a web application framework written in Ruby. The architecture is similar to WebObjects"
HOMEPAGE="http://www.spice-of-life.net/cgikit/index_en.html"
SRC_URI="http://www.spice-of-life.net/cgikit/archive/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""
USE_RUBY="ruby18 ruby19"

DEPEND="|| ( >=dev-lang/ruby-1.8.0
		dev-lang/ruby-cvs )"

src_compile() {
	ruby install.rb config || die
}

src_install() {
	ruby install.rb install --prefix=${D} || die
	erubydoc
}
