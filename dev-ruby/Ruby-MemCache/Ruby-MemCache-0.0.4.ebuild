# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/Ruby-MemCache/Ruby-MemCache-0.0.4.ebuild,v 1.4 2007/01/05 16:40:41 flameeyes Exp $

inherit ruby

DESCRIPTION="memcache bindings for Ruby"
HOMEPAGE="http://www.deveiate.org/projects/RMemCache/"
SRC_URI="http://www.deveiate.org/code/${P}.tar.bz2"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd ~x86"
IUSE=""

RDEPEND="dev-ruby/IO-Reactor"

src_compile() { :; }

src_install() {
	insinto "$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')"
	doins lib/memcache.rb

	erubydoc
}
