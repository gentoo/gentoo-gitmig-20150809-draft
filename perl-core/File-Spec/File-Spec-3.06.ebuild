# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Spec/File-Spec-3.06.ebuild,v 1.6 2005/08/13 23:18:15 hansmi Exp $

MY_P="PathTools-${PV}"
S=${WORKDIR}/${MY_P}

myconf='INSTALLDIRS=vendor'
inherit perl-module

DESCRIPTION="Handling files and directories portably"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${P}.readme"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="dev-perl/module-build"
