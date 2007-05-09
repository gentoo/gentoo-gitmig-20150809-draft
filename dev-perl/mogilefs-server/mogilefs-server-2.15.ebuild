# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mogilefs-server/mogilefs-server-2.15.ebuild,v 1.1 2007/05/09 08:16:13 robbat2 Exp $

inherit perl-module

DESCRIPTION="Server for the MogileFS distributed file system"
HOMEPAGE="http://search.cpan.org/search?query=mogilefs-server&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE="mysql sqlite"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/Net-Netmask
		>=dev-perl/Danga-Socket-1.57
		>=dev-perl/Sys-Syscall-0.22
		>=dev-perl/Perlbal-1.57
		dev-perl/Gearman-Server
		dev-perl/libwww-perl
		dev-perl/Cache-Memcached
		mysql? ( dev-perl/DBD-mysql )
		sqlite? ( dev-perl/DBD-SQLite )
		dev-lang/perl"
mydoc="CHANGES TODO"

# You need a local MySQL server for this
#SRC_TEST="do"

src_install() {
	perl-module_src_install || die "perl-module_src_install failed"
	cd ${S}
	dodoc doc/*.txt
}
