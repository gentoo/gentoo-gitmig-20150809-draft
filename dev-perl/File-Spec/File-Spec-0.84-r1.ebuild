# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Spec/File-Spec-0.84-r1.ebuild,v 1.10 2004/04/28 01:35:31 vapier Exp $

myconf='INSTALLDIRS=vendor'
inherit perl-module

DESCRIPTION="Handling files and directories portably"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64 s390"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0-r12"
