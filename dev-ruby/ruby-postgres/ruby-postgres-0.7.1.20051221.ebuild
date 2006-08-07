# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-postgres/ruby-postgres-0.7.1.20051221.ebuild,v 1.1 2006/08/07 12:00:02 caleb Exp $

inherit ruby gems

MY_P=ruby-postgres-0.7.1.2005.12.21.gem

DESCRIPTION="An extension library to access a PostgreSQL database from Ruby"
HOMEPAGE="http://ruby.scripting.ca/postgres"
SRC_URI="http://ruby.scripting.ca/postgres/archive/$MY_P"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""
USE_RUBY="ruby18"
DEPEND=">=dev-db/postgresql-6.4"
