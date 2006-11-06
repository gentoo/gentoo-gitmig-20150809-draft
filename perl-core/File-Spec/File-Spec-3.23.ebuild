# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Spec/File-Spec-3.23.ebuild,v 1.1 2006/11/06 17:06:34 mcummings Exp $

inherit perl-module

MY_P="PathTools-${PV}"
S=${WORKDIR}/${MY_P}

myconf='INSTALLDIRS=vendor'

DESCRIPTION="Handling files and directories portably"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${P}.readme"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-lang/perl
		dev-perl/ExtUtils-CBuilder"
DEPEND="${RDEPEND}
		dev-perl/module-build"
