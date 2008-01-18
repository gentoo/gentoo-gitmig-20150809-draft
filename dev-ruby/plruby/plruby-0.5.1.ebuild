# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/plruby/plruby-0.5.1.ebuild,v 1.1 2008/01/18 00:29:03 caleb Exp $

inherit ruby

DESCRIPTION="plruby language for PostgreSQL"
HOMEPAGE="http://moulon.inra.fr/ruby/plruby.html"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8
	dev-db/postgresql"

RUBY_ECONF="--with-pgsql-include=/usr/include/postgresql --with-pgsql-lib=/usr/lib"
