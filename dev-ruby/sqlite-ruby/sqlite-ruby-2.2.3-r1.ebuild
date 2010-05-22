# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite-ruby/sqlite-ruby-2.2.3-r1.ebuild,v 1.19 2010/05/22 15:59:58 flameeyes Exp $

inherit ruby gems

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="http://rubyforge.org/projects/sqlite-ruby/"
LICENSE="BSD"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.

KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"
DEPEND="=dev-db/sqlite-2*"
