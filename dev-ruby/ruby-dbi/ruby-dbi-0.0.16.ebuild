# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-dbi/ruby-dbi-0.0.16.ebuild,v 1.3 2002/07/23 07:30:12 seemant Exp $

S=${WORKDIR}/ruby-dbi-all
DESCRIPTION="Ruby/DBI - a database independent interface for accessing databases - similar to Perl's DBI"
SRC_URI="mirror://sourceforge/ruby-dbi/ruby-dbi-all-${PV}.tar.gz"
HOMEPAGE="http://ruby-dbi.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND="=dev-lang/ruby-1.6*
	mysql? ( >=dev-db/mysql-3.23.49 )
	postgres? ( >=dev-db/postgresql-7.1.3-r4 )
	firebird? ( >=dev-db/firebird-1.0-r1 )
	odbc? ( >=dev-db/unixODBC-2.0.6 )"

src_compile() {

	myconf="dbi,dbd_proxy,dbd_sqlrelay"
	use mysql && myconf="${myconf},dbd_mysql"
	use postgres && myconf="${myconf},dbd_pg"
	use firebird && myconf="${myconf},dbd_interbase"
	use odbc && myconf="${myconf},dbd_odbc"
	
	ruby setup.rb config \
		--with=${myconf} \
		--bin-dir="${D}/usr/bin" \
		--rb-dir="${D}/usr/lib/ruby/site_ruby/1.6" \
		--so-dir="${D}/usr/lib/ruby/site_ruby/1.6/i686-linux-gnu" || die

	ruby setup.rb setup || die

}

src_install () {

	dodir /usr/bin
	dodir /usr/lib/ruby/site_ruby/1.6
	dodir /usr/lib/ruby/site_ruby/1.6/i686-linux-gnu
	
	ruby setup.rb install || die

	dodoc LICENSE README
}
