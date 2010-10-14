# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-SQLite/DBD-SQLite-1.29-r2.ebuild,v 1.6 2010/10/14 19:18:23 ranger Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Self Contained RDBMS in a DBI Driver"

SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/DBI-1.57
	>=dev-db/sqlite-3.6.22[extensions]
	!<dev-perl/DBD-SQLite-1"
DEPEND="${RDEPEND}"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare
	sed -i 's/^if ( 0 )/if ( 1 )/' "${S}"/Makefile.PL || die

	myconf="SQLITE_LOCATION=${EPREFIX}/usr"
}
