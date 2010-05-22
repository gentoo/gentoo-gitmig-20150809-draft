# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cgikit/cgikit-1.2.1.ebuild,v 1.8 2010/05/22 15:05:57 flameeyes Exp $

RUBY_BUG_145222=yes
inherit ruby

DESCRIPTION="CGIKit is a web application framework written in Ruby. The architecture is similar to WebObjects"
HOMEPAGE="http://www.spice-of-life.net/cgikit/index_en.html"
SRC_URI="http://www.spice-of-life.net/cgikit/archive/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 x86"
IUSE="examples"
USE_RUBY="ruby18"

DEPEND=">=dev-lang/ruby-1.8.0"

src_unpack() {
	ruby_src_unpack

	grep -rl --null '#!/usr/local/bin/ruby' "${S}" | xargs -0 \
		sed -i -e 's:#!/usr/local/bin/ruby:#!/usr/bin/ruby:'
}

src_compile() {
	ruby install.rb config || die
}

src_install() {
	ruby install.rb install --prefix="${D}" || die
	erubydoc
}
