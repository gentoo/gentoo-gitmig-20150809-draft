# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gnuradius/gnuradius-1.3.ebuild,v 1.3 2005/04/14 20:43:20 mrness Exp $

MY_P=radius-${PV}

DESCRIPTION="GNU radius authentication server"
HOMEPAGE="http://www.gnu.org/software/radius/radius.html"
SRC_URI="ftp://ftp.gnu.org/gnu/radius/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="guile mysql postgres odbc dbm nls snmp pam static debug"

DEPEND="!net-dialup/freeradius
	!net-dialup/cistronradius
	guile? ( >=dev-util/guile-1.4 )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	odbc? ( || ( dev-db/unixODBC dev-db/libiodbc ) )
	readline? ( sys-libs/readline )
	dbm? ( sys-libs/gdbm )
	snmp? ( net-analyzer/net-snmp )
	pam? ( sys-libs/pam )"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf=" \
		`use_with guile` \
		`use_with mysql` \
		`use_with postgres` \
		`use_with odbc` \
		`use_with readline` \
		`use_enable dbm` \
		`use_enable nls` \
		`use_enable snmp` \
		`use_enable pam` \
		`use_enable debug` \
		`use_enable static` "

	if useq guile; then
		myconf="$myconf --with-client --with-server-guile"
	fi

	econf $myconf || die "configuration failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "installation failed"
}
