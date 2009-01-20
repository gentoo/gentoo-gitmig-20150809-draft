# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite-ruby/sqlite-ruby-2.2.3-r1.ebuild,v 1.17 2009/01/20 23:35:06 aballier Exp $

inherit ruby gems

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="http://rubyforge.org/projects/sqlite-ruby/"
LICENSE="BSD"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"
DEPEND="=dev-db/sqlite-2*"
