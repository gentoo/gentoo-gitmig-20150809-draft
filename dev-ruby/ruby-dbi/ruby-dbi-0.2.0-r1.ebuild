# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-dbi/ruby-dbi-0.2.0-r1.ebuild,v 1.9 2009/12/20 13:53:20 graaff Exp $

EAPI="1"

inherit "ruby"

DESCRIPTION="Ruby/DBI - a database independent interface for accessing databases - similar to Perl's DBI"
HOMEPAGE="http://ruby-dbi.rubyforge.org"
SRC_URI="http://rubyforge.org/frs/download.php/33959/dbi-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ~sparc x86"
IUSE="examples firebird odbc oracle postgres mysql sqlite sqlite3"

DEPEND="
	mysql? ( dev-ruby/mysql-ruby )
	postgres? ( dev-ruby/ruby-postgres )
	firebird? ( >=dev-db/firebird-1.0-r1 )
	odbc? ( dev-ruby/ruby-odbc )
	oracle? ( dev-ruby/ruby-oci8 )
	sqlite? ( dev-db/sqlite:0 )
	sqlite3? ( dev-db/sqlite:3 )"

S="${WORKDIR}/dbi-${PV}"
PATCHES=( "${FILESDIR}/ruby-dbi-destdir-gentoo.diff"
	"${FILESDIR}/ruby-dbi-0.1.1-destdir-gentoo.diff" )

src_compile() {
	myconf="dbi,dbd_proxy,dbd_sqlrelay"
	use mysql && myconf="${myconf},dbd_mysql"
	use postgres && myconf="${myconf},dbd_pg"
	use firebird && myconf="${myconf},dbd_interbase"
	use odbc && myconf="${myconf},dbd_odbc"
	use oracle && myconf="${myconf},dbd_oracle"
	use sqlite && myconf="${myconf},dbd_sqlite"
	use sqlite3 && myconf="${myconf},dbd_sqlite3"

	ruby setup.rb config \
		--with=${myconf} --ruby-path=/usr/bin/ruby || die
	ruby setup.rb setup || die
}

src_install() {

	DESTDIR=${D} ruby setup.rb install || die

	dodoc README

	if use examples; then
		cp -pPR examples "${D}/usr/share/doc/${PF}" || die "cp examples failed"
	fi
}
