# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-bdb/ruby-bdb-0.6.5.ebuild,v 1.6 2009/06/18 22:30:14 flameeyes Exp $

inherit db-use ruby

MY_P="${P/ruby-}"
DESCRIPTION="Ruby interface to Berkeley DB"
HOMEPAGE="http://moulon.inra.fr/ruby/bdb.html"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc ~x86 ~x86-fbsd"
IUSE="examples"
USE_RUBY="ruby16 ruby18 ruby19"

S=${WORKDIR}/${MY_P}

DEPEND=">=sys-libs/db-3.2.9"
RDEPEND="${DEPEND}"

src_compile() {
	RUBY_ECONF="--with-db-include=$(db_includedir)
		--with-db-version=$(db_libname | sed -e 's:db::')"
	ruby_src_compile
}

src_install() {
	ruby_src_install
	dodoc Changes || die
	dohtml bdb.html || die
}
