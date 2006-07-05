# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/dbix-searchbuilder/dbix-searchbuilder-0.95.ebuild,v 1.9 2006/07/05 14:46:46 ian Exp $

inherit perl-module

MY_P=DBIx-SearchBuilder-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Encapsulate SQL queries and rows in simple perl objects"
SRC_URI="mirror://cpan/authors/id/J/JE/JESSE/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/J/JE/JESSE/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha ~hppa"
IUSE=""

DEPEND="dev-perl/class-returnvalue"
RDEPEND="${DEPEND}"