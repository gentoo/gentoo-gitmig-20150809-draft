# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mytop/mytop-1.4.ebuild,v 1.14 2005/12/26 04:15:10 weeve Exp $

inherit perl-app

DESCRIPTION="mytop - a top clone for mysql"
HOMEPAGE="http://jeremy.zawodny.com/mysql/mytop/"
SRC_URI="http://jeremy.zawodny.com/mysql/mytop/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ppc sparc x86"
SLOT="0"
IUSE=""

DEPEND="dev-perl/DBD-mysql
	perl-core/Getopt-Long
	dev-perl/TermReadKey
	dev-perl/Term-ANSIColor
	perl-core/Time-HiRes
	>=sys-apps/sed-4"

src_install() {
	perl-module_src_install
	sed -i "s|socket        => '',|socket        => '/var/run/mysqld/mysqld.sock',|g" ${D}/usr/bin/mytop
}
