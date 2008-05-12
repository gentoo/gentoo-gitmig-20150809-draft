# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite-ruby/sqlite-ruby-2.2.3-r1.ebuild,v 1.15 2008/05/12 09:55:22 corsair Exp $

inherit ruby gems

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="http://rubyforge.org/projects/sqlite-ruby/"
LICENSE="BSD"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18 ruby19"
DEPEND="=dev-db/sqlite-2*"
