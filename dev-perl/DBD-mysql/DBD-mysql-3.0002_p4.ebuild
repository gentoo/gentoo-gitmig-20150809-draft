# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-3.0002_p4.ebuild,v 1.3 2006/04/22 21:20:28 flameeyes Exp $

inherit eutils perl-module

MY_P="${P/_p/_}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Perl DBD:mysql Module"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/C/CA/CAPTTOFU/"
SRC_URI="mirror://cpan/authors/id/C/CA/CAPTTOFU/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

IUSE=""

DEPEND="dev-perl/DBI
	dev-db/mysql"

mydoc="ToDo"

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/mysql-5.0-new_bit_type.patch"
}
