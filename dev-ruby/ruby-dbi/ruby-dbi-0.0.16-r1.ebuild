# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-dbi/ruby-dbi-0.0.16-r1.ebuild,v 1.1 2004/03/31 19:02:42 usata Exp $

inherit ruby

DESCRIPTION="Ruby/DBI - a database independent interface for accessing databases - similar to Perl's DBI"
HOMEPAGE="http://ruby-dbi.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-dbi/ruby-dbi-all-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"
KEYWORDS="x86"
IUSE="firebird odbc postgres mysql"

DEPEND="dev-lang/ruby
	mysql? ( >=dev-db/mysql-3.23.49 )
	postgres? ( >=dev-db/postgresql-7.1.3-r4 )
	firebird? ( >=dev-db/firebird-1.0-r1 )
	odbc? ( >=dev-db/unixODBC-2.0.6 )"

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

	ruby setup.rb config \
		--with=${myconf} --ruby-path=/usr/bin/ruby || die
	ruby setup.rb setup || die
}

src_install() {
	DESTDIR=${D} ruby setup.rb install || die

	dodoc LICENSE README
}
