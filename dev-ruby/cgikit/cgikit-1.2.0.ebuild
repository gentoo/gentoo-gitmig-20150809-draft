# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cgikit/cgikit-1.2.0.ebuild,v 1.6 2006/01/31 19:43:44 agriffis Exp $

inherit ruby

DESCRIPTION="CGIKit is a web application framework written in Ruby. The architecture is similar to WebObjects"
HOMEPAGE="http://www.spice-of-life.net/cgikit/index_en.html"
SRC_URI="http://www.spice-of-life.net/cgikit/archive/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha ia64 ppc x86"
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
