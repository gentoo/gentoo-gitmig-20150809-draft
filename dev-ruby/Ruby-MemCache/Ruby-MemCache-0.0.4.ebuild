# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/Ruby-MemCache/Ruby-MemCache-0.0.4.ebuild,v 1.2 2006/09/24 20:17:55 flameeyes Exp $

inherit ruby

DESCRIPTION="memcache bindings for Ruby"
HOMEPAGE="http://www.deveiate.org/projects/RMemCache/"
SRC_URI="http://www.deveiate.org/code/${P}.tar.bz2"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd"
IUSE=""

RDEPEND="dev-ruby/IO-Reactor"

src_compile() {
	einfo "Nothing to do"
}

src_install() {
	insinto "$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')"
	doins lib/memcache.rb

	erubydoc
}
