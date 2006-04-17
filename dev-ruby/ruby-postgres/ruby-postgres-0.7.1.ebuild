# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-postgres/ruby-postgres-0.7.1.ebuild,v 1.11 2006/04/17 18:10:34 flameeyes Exp $

inherit ruby

DESCRIPTION="An extension library to access a PostgreSQL database from Ruby"
HOMEPAGE="http://ruby.scripting.ca/postgres"
SRC_URI="http://ruby.scripting.ca/postgres/archive/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 mips ppc sparc x86 ~x86-fbsd"
IUSE=""
USE_RUBY="ruby18"
DEPEND=">=dev-db/postgresql-6.4"
