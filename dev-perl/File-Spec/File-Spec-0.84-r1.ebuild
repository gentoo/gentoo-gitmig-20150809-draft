# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Spec/File-Spec-0.84-r1.ebuild,v 1.3 2003/08/04 01:09:56 gmsoft Exp $

myconf='INSTALLDIRS=vendor'
inherit perl-module

DESCRIPTION="Handling files and directories portably"
SRC_URI="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
newdepend ">=dev-lang/perl-5.8.0-r12"
KEYWORDS="x86 amd64 alpha ~arm hppa mips ppc sparc"

