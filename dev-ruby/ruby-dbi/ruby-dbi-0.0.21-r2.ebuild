# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-dbi/ruby-dbi-0.0.21-r2.ebuild,v 1.4 2006/10/20 21:24:48 agriffis Exp $

inherit ruby eutils

DESCRIPTION="Ruby/DBI - a database independent interface for accessing databases - similar to Perl's DBI"
HOMEPAGE="http://ruby-dbi.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-dbi/ruby-dbi-all-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc ~sparc x86"
USE_RUBY="ruby18 ruby19"
IUSE="firebird odbc postgres mysql sqlite"

DEPEND="virtual/ruby
	mysql? ( dev-ruby/mysql-ruby )
	postgres? ( dev-ruby/ruby-postgres )
	firebird? ( >=dev-db/firebird-1.0-r1 )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	sqlite? ( =dev-db/sqlite-2* )"

S=${WORKDIR}/ruby-dbi-all

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-destdir-gentoo.diff
}

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
