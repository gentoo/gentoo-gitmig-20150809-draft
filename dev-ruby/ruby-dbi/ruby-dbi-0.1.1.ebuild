# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-dbi/ruby-dbi-0.1.1.ebuild,v 1.6 2007/09/09 19:02:24 killerfox Exp $

RUBY_BUG_145222=yes
inherit ruby

DESCRIPTION="Ruby/DBI - a database independent interface for accessing databases - similar to Perl's DBI"
HOMEPAGE="http://ruby-dbi.rubyforge.org"
SRC_URI="http://rubyforge.org/frs/download.php/12368/dbi-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
USE_RUBY="ruby18 ruby19"
IUSE="examples firebird odbc postgres mysql sqlite"

DEPEND="virtual/ruby
	mysql? ( dev-ruby/mysql-ruby )
	postgres? ( dev-ruby/ruby-postgres )
	firebird? ( >=dev-db/firebird-1.0-r1 )
	odbc? ( dev-ruby/ruby-odbc )
	sqlite? ( =dev-db/sqlite-2* )"

S=${WORKDIR}/ruby-dbi
PATCHES="${FILESDIR}/ruby-dbi-destdir-gentoo.diff
	${FILESDIR}/ruby-dbi-0.1.1-destdir-gentoo.diff"

src_compile() {
	myconf="dbi,dbd_proxy,dbd_sqlrelay"
	use mysql && myconf="${myconf},dbd_mysql"
	use postgres && myconf="${myconf},dbd_pg"
	use firebird && myconf="${myconf},dbd_interbase"
	use odbc && myconf="${myconf},dbd_odbc"
	use sqlite && myconf="${myconf},dbd_sqlite"

	ruby setup.rb config \
		--with=${myconf} --ruby-path=/usr/bin/ruby || die
	ruby setup.rb setup || die
}

src_install() {

	DESTDIR=${D} ruby setup.rb install || die

	dodoc LICENSE README
}
