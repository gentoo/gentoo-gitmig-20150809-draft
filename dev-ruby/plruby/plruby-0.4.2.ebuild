# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/plruby/plruby-0.4.2.ebuild,v 1.1 2004/07/04 21:58:37 nakano Exp $

inherit ruby

SLOT="0"
LICENSE="Ruby"
KEYWORDS="~x86"
DESCRIPTION="plruby language for PostgreSQL"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${P}.tar.gz"
HOMEPAGE="http://moulon.inra.fr/ruby/plruby.html"
IUSE=""
DEPEND=">=dev-lang/ruby-1.4.4 >=dev-db/postgresql-7.1"

EXTRA_ECONF="--with-pgsql-include=/usr/include/postgresql --with-pgsql-lib=/usr/lib"

