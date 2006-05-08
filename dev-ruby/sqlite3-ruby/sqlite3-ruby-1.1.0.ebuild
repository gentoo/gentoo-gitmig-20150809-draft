# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite3-ruby/sqlite3-ruby-1.1.0.ebuild,v 1.6 2006/05/08 17:11:23 seemant Exp $

inherit ruby gems

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="http://rubyforge.org/projects/sqlite-ruby/"
LICENSE="BSD"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

KEYWORDS="~amd64 ~ia64 ~ppc ~sparc x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18 ruby19"
DEPEND="=dev-db/sqlite-3*"




