# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Geert Bevin <gbevin@uwyn.com>
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-dbi/ruby-dbi-0.0.13.ebuild,v 1.4 2002/07/08 02:43:44 agriffis Exp $

S=${WORKDIR}/ruby-dbi-all
DESCRIPTION="database independent interface for accessing databases - similar to Perl's DBI"
SRC_URI="mirror://sourceforge/ruby-dbi/ruby-dbi-all-${PV}.tar.gz"
HOMEPAGE="http://ruby-dbi.sourceforge.net/"
LICENSE="Ruby"
KEYWORDS="x86"
SLOT="0"

DEPEND="=dev-lang/ruby-1.6*
	mysql? ( >=dev-db/mysql-3.23.49 )
	postgres? ( >=dev-db/postgresql-7.1.3-r4 )
	firebird? ( >=dev-db/firebird-1.0-r1 )
	odbc? ( >=dev-db/unixODBC-2.0.6 )"

src_compile() {

	my_config="dbi,dbd_proxy,dbd_sqlrelay"
	use mysql && my_config="$my_config,dbd_mysql"
	use postgres && my_config="$my_config,dbd_pg"
	use firebird && my_config="$my_config,dbd_interbase"
	use odbc && my_config="$my_config,dbd_odbc"
	
	ruby setup.rb config --with=$my_config \
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

