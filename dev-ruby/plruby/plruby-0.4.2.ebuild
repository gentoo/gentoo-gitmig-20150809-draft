# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/plruby/plruby-0.4.2.ebuild,v 1.7 2010/06/21 21:09:14 mr_bones_ Exp $

inherit ruby

DESCRIPTION="plruby language for PostgreSQL"
HOMEPAGE="http://moulon.inra.fr/ruby/plruby.html"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.4.4
	dev-db/postgresql-server"

RUBY_ECONF="--with-pgsql-include=/usr/include/postgresql --with-pgsql-lib=/usr/lib"
