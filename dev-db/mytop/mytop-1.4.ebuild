# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mytop/mytop-1.4.ebuild,v 1.4 2004/06/29 17:07:18 agriffis Exp $

inherit perl-module

DESCRIPTION="mytop - a top clone for mysql"
SRC_URI="http://jeremy.zawodny.com/mysql/mytop/${P}.tar.gz"
HOMEPAGE="http://jeremy.zawodny.com/mysql/mytop/"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""
DEPEND="dev-perl/DBD-mysql
	dev-perl/Getopt-Long
	dev-perl/TermReadKey
	dev-perl/Term-ANSIColor
	dev-perl/Time-HiRes
	>=sys-apps/sed-4"

src_install() {
	perl-module_src_install
	sed -i "s|socket        => '',|socket        => '/var/run/mysqld/mysqld.sock',|g" ${D}/usr/bin/mytop
}
