# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DB_File/DB_File-1.808.ebuild,v 1.3 2004/07/14 17:18:36 agriffis Exp $

inherit perl-module

DESCRIPTION="A Berkeley DB Support Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/DB_File/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/DB_File/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~sparc ~hppa ~alpha ~ia64 ~ppc ~amd64 ~mips"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	sys-libs/db"

mydoc="Changes"
